# Terraform AWS Lab 4

## Опис

У роботі реалізовано безсерверний застосунок на базі AWS з використанням Terraform.
Система автоматично отримує дані про погоду із зовнішнього API, зберігає їх у S3 та надає доступ через HTTP API.

## Передумови

Для запуску необхідно:

* встановлений Terraform (версія ≥ 1.10)
* встановлений AWS CLI
* налаштований доступ до AWS (`aws configure`)
* обраний регіон (наприклад, `eu-central-1`)

## Використання

### Розгортання інфраструктури

```
terraform init
terraform apply -auto-approve
```

### Отримання URL API

```
export API_URL=$(terraform output -raw api_url)
```

### Тестування

```
curl $API_URL/digest/latest
```

### Видалення інфраструктури

```
terraform destroy -auto-approve
```
