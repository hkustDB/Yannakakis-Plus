create or replace view aggView5452599294837116050 as select id as v12, title as v31 from title as t;
create or replace view aggJoin4774942855109021833 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView5452599294837116050 where mk.movie_id=aggView5452599294837116050.v12;
create or replace view aggView2046980177441311696 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin7057627573086081184 as select movie_id as v12 from movie_companies as mc, aggView2046980177441311696 where mc.company_id=aggView2046980177441311696.v1;
create or replace view aggView7863443670677494012 as select v12 from aggJoin7057627573086081184 group by v12;
create or replace view aggJoin2040737801703978972 as select v18, v31 as v31 from aggJoin4774942855109021833 join aggView7863443670677494012 using(v12);
create or replace view aggView2320667345211567521 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin3557422312116604140 as select v31 from aggJoin2040737801703978972 join aggView2320667345211567521 using(v18);
select MIN(v31) as v31 from aggJoin3557422312116604140;
