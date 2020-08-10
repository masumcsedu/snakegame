# The Classic Snake Game #

This is the classic snake game with snake & food. Snake eat food & grow its size & increase points by 10. The snake should avoid obstacle, border edge & its trail.

SpriteKit is used for this game.

### Main Part ###

* Game Scenes
* Game Controller
* Board Master
* Board Cells
* Snake
* Food & Obstacle
* Leader Board
* Utility


#### Game Scenes #
This game has two SpriteKit scene MainMenuScene & GameScene which is SKScene. One for menu & another for game. This is single ViewController application which shows two scenes. GameScene initiate the GameController which control the game business logic. GameScene sends user interaction events to GameController & its response accordingly.

#### Game Controller #
Game Controller mainly control the business logic of game. Its initiate BoardMaster which is responsible for managing the board. BoardMaster sends game events like didFindCollision, didFindFood & didFinishMove to Game Controller & its response accordingly. When its find snake collision with obstacle, border wall or its trail, its delegate back the event to GameScene & GameScene show the menu.

#### Board Master #
Board Master is responsible for managing the board line adding foods, snake & obstacle on board under supervision of Game Controller. It also can move the snake to direction according to Game Controller commands. During snake move command, its find the next cell to move & sends event like didFindCollision & didFindFood to Game Controller if necessary. Board master is also responsible to add the food on random cell of board periodically.

#### Board Cells #
Board Master keep tow dimensional array of cells which is indexed with row & column. Each cell has its type(empty, food, snake, block etc), position, row & column. When Board Master moves snake from one cell to another cell & its moves board to opposite direction as snake head is alway in the centre position of the screen.

#### Snake #
Snake is managed by a link list of snake organ. There is a super class called SnakeOrgan & its 3 subclass SnakeHead, SnakeBody & SnakeTail. Snake keep the reference of its head & tail. When snake move, it's command the head to move to next cell & every organ command next cell to move its current cell. Snake give to rotation angle along with move command to head, and every organ pass its previous rotation to next organ. This way the snake move through the board. When head is moved to next cell its change the type of cell to snake & when tail is moved to next cell its change the type of cell to empty. When snake find food its inform tail regarding this & tail does not move that time instead it add a new SnakeBody organ to previous organs position.

#### Food & Obstacle #
Food & Obstacle are placed on board by board master. When these are placed on any cell, its change the type of cell to food or block. After creating these objects, it can be placed on cell & can be destroyed from cell.

#### Leader Board #
Leader Board is not enabled here. To enable leader board, 'Game Center' capability need to be added in the app. Paid apple developer account is needed to do this. Then create leader board in app store connect with a identifier. Replace leaderboardIdentifier 'shamsur.rahman.snake.highscore' in GameKitHelper.swift with this identifier. Then it will work.

#### Utility #
Utility contains mainly static utility method. Its do many task like draw board image, save score to UserDefaults, place scene node on parent node etc.
