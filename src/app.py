import json
import boto3
import os
import urllib.request
from datetime import datetime

s3 = boto3.client("s3")

BUCKET = os.environ.get("BUCKET_NAME")

def handler(event, context):
    try:
        # якщо виклик від API Gateway
        if "requestContext" in event:
            key = "latest.json"

            obj = s3.get_object(Bucket=BUCKET, Key=key)
            data = json.loads(obj["Body"].read())

            return {
                "statusCode": 200,
                "body": json.dumps({
                    "s3_key": key,
                    "data": data
                })
            }

        # якщо виклик від EventBridge
        with urllib.request.urlopen(
            "https://api.open-meteo.com/v1/forecast?latitude=50&longitude=30&current_weather=true"
        ) as response:
            weather = json.loads(response.read().decode())

        key = "latest.json"

        s3.put_object(
            Bucket=BUCKET,
            Key=key,
            Body=json.dumps({
                "timestamp": datetime.now().isoformat(),
                "weather": weather
            })
        )

        return {"status": "updated"}

    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }