Задание 1
=========

0. Версия:
   ```
   # terraform --version
   Terraform 1.10.5
   on linux_amd64
   ```
1. ---
2. Секреты:
   ```
   # tail -1 .gitignore
   personal.auto.tfvars
   ```
3. random_password в [tfstate](./terraform.tfstate):
   ```
   # jq -r < terraform.tfstate '.resources[].instances[].attributes.result'
   DpXr1S0djRtitCSm
   ```
4. `terraform validate`:
   ```
   ╷
   │ Error: Missing name for resource
   │
   │   on main.tf line 23, in resource "docker_image":
   │   23: resource "docker_image" {
   │
   │ All resource blocks must have 2 labels (type, name).
   ╵
   ```
   не объявлено имя ресурса

   ```
   ╷
   │ Error: Invalid resource name
   │
   │   on main.tf line 28, in resource "docker_container" "1nginx":
   │   28: resource "docker_container" "1nginx" {
   │
   │ A name must start with a letter or underscore and may contain only letters, digits, underscores, and dashes.
   ╵
   ```
   невалидное имя ресурса - не может начинаться с цифры

   ```
   ╷
   │ Error: Reference to undeclared resource
   │
   │   on main.tf line 30, in resource "docker_container" "nginx-1":
   │   30:   name  = "example_${random_password.random_string_FAKE.resulT}"
   │
   │ A managed resource "random_password" "random_string_FAKE" has not been declared in the root module.
   ╵
   ```
   невалидный референс поля - random_string_FAKE не объявлен, у random_password нет поля resulT

5. [diff](./fix.diff)
   ```
   # docker ps
   CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                  NAMES
   d1957eebdc75   97662d24417b   "/docker-entrypoint.…"   49 seconds ago   Up 48 seconds   0.0.0.0:9090->80/tcp   example_DpXr1S0djRtitCSm
   ```

6. Зачем гуглить и гадать, если есть документация?
   ```
   # terraform apply -help
   ...
     -auto-approve          Skip interactive approval of plan before applying.
   ...
   ```
   Можно очень огорчиться, если выполнять такое без `terraform plan`.

   ```
   # docker ps
   CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                  NAMES
   41f7a03be3f0   97662d24417b   "/docker-entrypoint.…"   19 seconds ago   Up 18 seconds   0.0.0.0:9090->80/tcp   example_DpXr1S0djRtitCSm
   ```
7. `terraform destroy`, [tfstate](./terraform-after-destroy.tfstate)
8. [код](https://github.com/netology-code/ter-homeworks/blob/main/01/src/main.tf#L26):
   ```hcl
   resource "docker_image" "..." {
     #...
     keep_locally = true
     #...
   }
   ```
   [документация](https://registry.terraform.io/providers/abh80/docker/latest/docs/resources/image#keep_locally-1):
   > `keep_locally` (Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation
