shter-15: 02
============
_Для аутентификации использовался стандартный механизм яндекс.облака с использованием переменных окружения `YC_...`, поэтому переменные и атрибуты для аутентификации в облаке в коде закомментированы._

_Поскольку задание предполагает добавление новых вм в другой зоне, пришлось адаптировать структуру, чтобы она поддерживала несколько зон, а именование переменных не потеряло смысла. Заодно в решении появился пример применения for_each._

[Решение](./src).

Задание 1
---------
![list vm / run curl](images/1-01.png)

![cloud gui](images/1-02.png)

4: [yandex_compute_instance.platform.platform_id](https://yandex.cloud/en/docs/compute/concepts/vm-platforms), [yandex_compute_instance.platform.resources](https://yandex.cloud/en/docs/compute/concepts/performance-levels): неверно задана платформа, неверно указаны ресурсы (количество ядер, возможно процент ядра)

6: [Так](https://yandex.cloud/en/docs/compute/concepts/performance-levels) [дешевле](https://yandex.cloud/en/docs/compute/concepts/preemptible-vm).

Задание 4
---------
```
vms = [
  {
    "external_ip" = "84.201.156.242"
    "fqdn" = "fhme3ae6qt465v1ciafq.auto.internal"
    "instance_name" = "netology-develop-platform-web"
  },
  {
    "external_ip" = "51.250.103.134"
    "fqdn" = "epdgjdragr06chuqecum.auto.internal"
    "instance_name" = "netology-develop-platform-db"
  },
]
```
