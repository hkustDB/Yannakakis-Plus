create or replace view aggView6322006450087589425 as select id as v12, title as v31 from title as t;
create or replace view aggJoin8205410039402876848 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView6322006450087589425 where mc.movie_id=aggView6322006450087589425.v12;
create or replace view aggView3603292105065563033 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin7646302988392738125 as select movie_id as v12 from movie_keyword as mk, aggView3603292105065563033 where mk.keyword_id=aggView3603292105065563033.v18;
create or replace view aggView7291962405756781232 as select v12 from aggJoin7646302988392738125 group by v12;
create or replace view aggJoin3315834034023045227 as select v1, v31 as v31 from aggJoin8205410039402876848 join aggView7291962405756781232 using(v12);
create or replace view aggView7298124097295388777 as select v1, MIN(v31) as v31 from aggJoin3315834034023045227 group by v1;
create or replace view aggJoin3075578075435457639 as select country_code as v3, v31 from company_name as cn, aggView7298124097295388777 where cn.id=aggView7298124097295388777.v1 and country_code= '[de]';
select MIN(v31) as v31 from aggJoin3075578075435457639;
