Классы и методы
----------------

Главный класс - Img::Img. Перед началом работы нужно вызвать его метод класса
init, передав путь к файлу конфигурации:

```
Img::Img.init('schema.yml')
```

После этого можно получить объект "таблицы" по её имени:

```
table=Img::Img.data('ИМЯ')
```

Для таблицы доступны методы получения данных:

- **filter(hash)**
  получить данные с фильтром. Каждый ключ хэша - имя столбца, значение -
  условие. Условие может быть равенством, массивом или диапазоном.
  Если столбец является отношением к другой таблице, то условие указывается в
  виде аналогичного хэша, но для другой таблицы;
- **all**
  получить все данные.

Все возвращаемые данные являются ROM Datasets, поэтому для получения реального
значения нужно вызвать .one, .to_a, или методы типа map/each/итп.

Примеры
--------

```
puts Img::Img.data('tasks').filter('owner' => {'email' => 'qwe'}).to_a.inspect
puts Img::Img.data('users').filter('tasks' => {'descr' => 'task number 1'}).inspect
```

Формат файла конфигурации
--------------------------

```
tables:
  ИМЯ_ТАБЛИЦЫ:
    driver: yaml             # имя драйвера источника данных
    location: 'data.yml'     # адрес источника данных
    schema:                  # описание полей
      id: int                # пример: поле id типа int
      name: str              # пример: поле name типа str
      author_id: int
      descr: str
    relations:               # ссылки на другие таблицы
      owner:                 # имя поля
        type: :belongs_to    # вид отношения
        table: users         # имя таблицы
        my_field: :author_id # поле ключа (обязательно с :)
        key: :id             # поле внешнего ключа (обязательно с :)

  users:
    driver: sql
    location: 'sqlite://test.db'
    schema:
      id: int
      name: str
      email: str
    relations:
      tasks:
        type: :has_many
        table: tasks
        my_field: :id
        key: :author_id
    options:
      foo: bar
```

Виды отношений
--------------

- **:belongs_to** ссылка на один внешний объект, его id указывается в поле с
  именем, заданным в my_field, а имя поля, в котором записан id - в key.
- **:has_many** все объекты из другой таблицы, где в поле, заданном в key, указан
  наш идентификатор (имя поля идентификатора задано в my_field)


TODO
-----

[+] для filter сделать обработку всех элементов хеша, а не только первого
[ ] для условий сделать сравнения (больше/меньше/и т.п.)
[ ] добавить тип "дата-время"

