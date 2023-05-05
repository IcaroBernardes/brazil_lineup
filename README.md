# Brazil Lineup

Dataviz on which clubs gave the most players to the male Brazilian Football team. This [page](https://icarobernardes.github.io/brazil_lineup/) has:

### Data on 488 draftings for the FIFA World Cups between 1932 and 2022

<img src="www/shapes/rio_de_janeiro.png" width="10%" /><img src="www/teams/botafogo.png" width="10%" /><img src="www/teams/vasco.png" width="10%" /><img src="www/teams/flamengo.png" width="10%" /><img src="www/teams/fluminense.png" width="10%" />

<img src="www/shapes/são_paulo.png" width="10%" /><img src="www/teams/sao_paulo.png" width="10%" /><img src="www/teams/santos.png" width="10%" /><img src="www/teams/palmeiras.png" width="10%" /><img src="www/teams/corinthians.png" width="10%" />

<img src="www/shapes/france.png" width="10%" /><img src="www/teams/paris_saint_germain.png" width="10%" /><img src="www/teams/lyon.png" width="10%" />

<img src="www/shapes/germany.png" width="10%" /><img src="www/teams/bayer_leverkusen.png" width="10%" /><img src="www/teams/bayern_de_munique.png" width="10%" />

<img src="www/shapes/turkey.png" width="10%" /><img src="www/teams/galatasaray.png" width="10%" />

<img src="www/shapes/united_states_of_america.png" width="10%" /><img src="www/teams/toronto.png" width="10%" />

### Ranked list of the countries by number of ceded players

<img src="www/app.png" width="100%" />

### List of clubs and the players they ceded

<img src="www/about2.png" width="100%" />

## The process

<img src="www/repository.png" align="right" width="50%" />

This dataviz was made with R, mostly `{ggiraph}`, in Quarto. I had to use some tricks to create this behaviour of "click and filter" data by country. I also had to make an effort to standardize the images: using `{ggpath}` to put them in the page and `{magick}` to manipulate images.

## Authorship

This dataviz was made by Ícaro Bernardes. To see more pieces like this follow me at:

- Twitter: [@IcaroBSC](https://twitter.com/icarobsc)
- Github: [@IcaroBernardes](https://github.com/IcaroBernardes)
- Linkedin: [@icarobsc](https://www.linkedin.com/in/icarobsc/)

Data was taken from [this](https://ge.globo.com/futebol/selecao-brasileira/noticia/2022/11/01/qual-clube-teve-mais-jogadores-convocados-pela-selecao-brasileira-para-copas-do-mundo.ghtml) Globo Esporte article.

