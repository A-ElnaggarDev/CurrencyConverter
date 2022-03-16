# Currency Converter
> this app make the end user able to convert from/to different currencies.

 below you will find how to use the app? and its software stack :)
---------------------------------------

# How to use the app? 
*   after open the app click on "From" button and choose cuerrency code.
*   after that click on "To" button and choose cuerrency code which you want to convert to.
*   you are able to set the amount of your currency by type the amount inside the the input under "From button"
*   by click on swap button this action swap the values in FROM and TO, and accordingly converted data changed.
*   by click on "Details" button you will go to see conversion between your currency with the amount you set before and ten other currencies. 

------------------------------------------------------------------------------

# Software stack
*   MVVM design architecture
```
i preffere using this architecture here to avoid massive view controller, making binding with rxswift and make unit testing easy.
```
*   RxSwift
```
using rxswift to make binding and make our app more reactive.
```

*   dependency injection
```
using dependency injection of api service to easy make unit testing, mocking and cleer dependencies.
```

*   unit testing
```
to make sure that each of our units work as expected and make code maintainable and reusable on long term.
```
---------------------------------------


