library(ggplot2)
library(gapminder)
library(dplyr)

summary(gapminder)
gapminder = gapminder
gapminderfilter <- gapminder%>% 
  dplyr::filter(!country == "Kuwait")

gapminderfilter


ggplot(gapminderfilter, aes(x = lifeExp, y = gdpPercap, color = continent, size = pop/100000)) + 
  geom_point() + 
  facet_wrap(~year,nrow=1) + 
  scale_y_continuous(trans ="sqrt") + 
  theme_bw() +
  xlab("Life Expectancy") +
  ylab("GDP per capita") +
  labs(size = "Population (100k)", color = "Continent")
ggsave("Cs3finalgraph1.png", width = 15, units = "in")


#Start of second group of graphs

gapminder_continent <- gapminderfilter%>%
  group_by(continent, year)%>%
  summarize(gdpPercapweighted = weighted.mean(x = gdpPercap, w = pop),
            pop = sum(as.numeric(pop)))


ggplot(gapminderfilter, aes(x = year, y = gdpPercap, color = continent, group = country, fill = continent, size = pop/100000)) + 
  geom_line(data = gapminderfilter, size = 0.5) +
  geom_point() +
  geom_line(data = gapminder_continent, aes(x = year, y = gdpPercapweighted), color = "black", inherit.aes = FALSE) +
  geom_point(data = gapminder_continent, aes(x = year, y = gdpPercapweighted, size = pop/100000), color = "black", inherit.aes = FALSE) +
  facet_wrap(~continent,nrow=1) +
  theme_bw() +
  labs(x = "Year", y = "GDP per capita", size = "Population (100k)")

#Weishan helped with the code inherit. aes = "False" to let R know not to inherit original aesetic.
ggsave("Cs3finalgraph2.png", width = 15, units = "in") 
