# SC42040 Final Assignment

Het is handig als de volgende regels aangehouden worden:

## Git rules

* When you start working on something, checkout to a new branch. 
  - Give your new branch a reasonable name like "LQR controller"
* When you finish working on something, create a pull request
  - If it is not finished, don't try to push to master. Much pain can be avoided.
  - When I think about it, never push to master.

## Coding rules

* In MATLAB, try to do things with matrices instead of loops if possible.
* Initial conditions, gains and such should be defined in a .m-file and not in the Simulink blocks.
* Subsystems with good names in Simulink
* Scopes are good for debugging, but if you want to actually make a figure, use a simout-block and plot in a .m-file.


## Figures rules

* All figures have to be in .esp format.
  - print(path,'-depsc') in MATLAB (I think)
* All figures should be saved in a "figures" folder.
* The figures should have names describing their content. Please follow the naming convention "prob2_1_descriptionofwhatthisis.eps".
* Label all axis, make titles, add labels. 
