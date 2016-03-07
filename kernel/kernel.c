void main(){
  /*
  * Create a pointer to a char, and point it to the first text cell of
  * video memory (ie, top left of the screen)
  */
  char* video_memory = (char*) 0xb8000;
  /*
   * At the address pointed to by video memory, store the character 'X'
   * (ie, display 'X' in the top left of the screen)
   */
  *video_memory = 'X';
}
