 # Quiz App

Aplikacja mobilna (Flutter) umożliwiająca, tworzenie i rozwiązywanie quizów. Aplikacja korzystała z Firebase jako bazy danych. 

## Funkcjonalności

- **Tworzenie quizu**: Użytkownik przy tworzeniu quizu podaje: ImgUrl(który miał być w tle okładki quizu), nazwe quizu i jego opis.

- **Dodawanie pytań**: Użytkownik podaje pytanie oraz cztery możliwe odpowiedzi i zazacza odpowiedź prawidłową

- **Tworzenie kont użytkowników**: Wykorzystając Authentication z Firebase aplikacja daje możliowość tworzenia kont użtkowników gdzie zapisuje jego quizy.

- **Rozwiązywanie quizu**: Użytkownik wybiera quiz, a aplikacja pobiera pytania z bazy danych i losowo je wyświetla. Użytkownik interaktywnie wybiera odpowiedzi na pytania, które są oceniane jako poprawne lub błędne. Po zakończeniu quizu, użytkownik jest przenoszony na ekran wyników, gdzie widzi liczbę poprawnych, błędnych oraz nieodpowiedzianych pytań.

## Technologie

- Flutter
- Dart
- Firebase
