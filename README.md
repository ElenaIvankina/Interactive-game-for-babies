# Interactive-game-for-babies


## Основной функционал
### Экран запуска приложения
### Экран меню игр
Слева кнопки: 
- Как говорят животные
- Один много
- Изучаем цвета
- Лягушки и фигуры  

Создание соответсвующего экрана и переход по нажатю кнопки
***
![image](https://user-images.githubusercontent.com/21302465/173004710-cac4b436-6558-4739-a635-7784768d09a5.png)
***
### Экран как говорят животные
1. Создание экрана с рандомной последовательностью карточек
2. Возможность вернуться в меню игр (кнопка домой) в любой момент
***
![image](https://user-images.githubusercontent.com/21302465/173005756-29514305-8f79-4d86-86c7-cb209c6ee531.png)
***
### Экран Один много
1. Создание экрана с вопросом (рандомное добавление один или много) и с 6 рандомными карточками
2. Правильный выбор обводится зеленым контуром и сохраняется
3. Неправильный обводится красным на 1 секунду и затухает
4. Как только все правильные карточки выбраны игра заканчивается
5. Предложение сыграть еще, если Да - создание нового экрана игры вместо текущего, Нет - возврат в меню игр
6. Возможность вернуться в меню игр (кнопка домой) в любой момент
***
![image](https://user-images.githubusercontent.com/21302465/173007702-3451523c-56fe-4c35-aeb5-cbbe680d9666.png)
***
### Экран Изучаем цвета
1. Создание экрана с вопросом (рандомное добавление цвета) и с 6 рандомными карточками
2. Правильный выбор обводится зеленым контуром и сохраняется
3. Неправильный обводится красным на 1 секунду и затухает
4. Как только все правильные карточки выбраны игра заканчивается
5. Предложение сыграть еще, если Да - создание нового экрана игры вместо текущего, Нет - возврат в меню игр
6. Возможность вернуться в меню игр (кнопка домой) в любой момент
***
![image](https://user-images.githubusercontent.com/21302465/173009347-0d2cc6a8-c6c3-4b6e-b973-893366624eb4.png)
***
### Экран Лягушки и фигуры
1. Создание экрана с лягушками и фигурами (рандомный выбор одного из 5 вариантов)
2. Если правильно протянули фигуру она остается на тени, ее нельзя больше двигать и обводится зеленым контуром
3. Если неправильно возвращается обратно, обведение красным на 1 секунду
4. Как только все фигуры на своих местах игра заканчивается
5. Предложение сыграть еще, если Да - создание нового экрана игры вместо текущего, Нет - возврат в меню игр
6. Возможность вернуться в меню игр (кнопка домой) в любой момент
***
![image](https://user-images.githubusercontent.com/21302465/173011318-507b596d-d45d-4f13-8b22-d1988a702c03.png)
***
## Мысли по реализации
- Верстка экранов кодом, так как нужно создавать новые экраны для следующих раундов игры на месте текущих
- Класс для текущей сессии игры (4 для каждой игры), в которую будет передаваться вопрос, кол-во верных ответов (сколько их всего), кол-во выбранных верных ответов (сколько уже ответили правильно, можно через паттерн делегат передавать), как только выбраны все правильные ответы запуск функции Завершения игры
- Класс с рандомными функциями (static наверное или синглтон сделать): 
  * функция рандомного выбора вопроса (возвращает один рандомный элемент из выбранного массива)
  * функция создания массива из 6 рандомных элементов из переданного массива, с условиями что элементы не должны повторяться, как минимум один элемент должен быть правильным для текущего вопроса
  * функция для перемешивания полученного массива, на выходе массив с другим порядком элементов
- Классы модели 
  * карточка животного (пока свойство название картинки)
  * карточка цветных предметов (свойства название картинки и цвет (перечисление цветов))
  * карточка один много (свойства название картинки и количество (перечисление один или много))
  * карточки фигур (свойства название картинки и тип фигуры (перечисление))
- Класс синглтон для хранения массивов игровых данных (массив с объектами карточек животных, цветных предметов, карточек один много, карточек фигур и лягушек)
***
## Мысли по дополнительному функционалу
- Красивый экран запуска приложения
- В целом дизайн посимпатичнее сделать
- В меню игр у каждой кнопки игры значок i - по нажатию всплывающее окно с подробным описанием что надо делать, пропадает когда в свободном месте кликаешь
- Поддержка и альбомной, и книжной ориентации
- Подсказки в цветах, один много (если 5 секунд нет действия - первый из невыбранных правильных ответов начинает подпрыгивать пару секунд)
- В цветах, один много, фигурах звуковое сопровождение правильного выбранного ответа и неправильного
- В цветах, один много, фигурах красивая анимация при Завершении игры - поздравление, звук и шарики снизу вверх или салют
- В карточках животных красивая анимация перелистывания карточек
- В карточках животных добавить озвучку для животных - кнопка с проигрыванием и аудиофайлы с нужным звуком
- Хранение игровых данных не в приложении, а удаленно




