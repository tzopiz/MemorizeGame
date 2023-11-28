# MemorizeGame

## Description:

MemorizeGame is a memory-based card matching game built in SwiftUI. The game presents a set of cards with various images faced down. The goal is to flip the cards two at a time, trying to match pairs by remembering their positions and contents.

## Features:

Card Set: An array of cards is initialized, each holding content (such as symbols or images) and their respective pairs.
Gameplay: Players flip two cards at a time. If the flipped cards match, they remain face up, and the player earns points. If they don’t match, the cards flip back down.
Scoring: Players earn points for every successful match and lose points for unsuccessful attempts.
Shuffling: The card set shuffles randomly at the start of each game, creating a new arrangement for a fresh challenge.
Memory Challenge: The game tests the player's memory as they progress, requiring them to remember card positions and content to make successful matches.
Record Keeping: The game maintains and displays the player's highest score as the game progresses. The record is saved and loaded between sessions, ensuring continuity and encouraging players to beat their best score.

## How to Play:

Launch the game to start a new session.
Tap or click on two cards to flip them over.
If the cards match, they stay face up. If not, they flip back down.
Keep flipping pairs until all cards are matched.
Try to achieve the highest score by remembering card positions and making successful matches.

## Project Structure:

`MemorizeGameModel`: Contains the logic for card flipping, matching, scoring, and record keeping.
`EmojiMemorizeGame`: Handles the user interface elements and interactions for the game.
`EmojiMemorizeGameView`: Integrates the game components into the main view of the application.
`Contributions and Feedback`: tg|vk|inst: tzopiz

Contributions, suggestions, and feedback are welcome! Feel free to fork the repository, create branches, and submit pull requests to enhance the game with new features, improvements, or bug fixes.
