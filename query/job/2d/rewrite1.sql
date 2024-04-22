create or replace view aggJoin1110889630865694669 as (
with aggView3659832925190754189 as (select id as v18 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v12 from movie_keyword as mk, aggView3659832925190754189 where mk.keyword_id=aggView3659832925190754189.v18);
create or replace view aggJoin2707837796504287480 as (
with aggView8316817589004506782 as (select id as v1 from company_name as cn where country_code= '[us]')
select movie_id as v12 from movie_companies as mc, aggView8316817589004506782 where mc.company_id=aggView8316817589004506782.v1);
create or replace view aggJoin6349368325273229626 as (
with aggView6430547779158828535 as (select v12 from aggJoin1110889630865694669 group by v12)
select v12 from aggJoin2707837796504287480 join aggView6430547779158828535 using(v12));
create or replace view aggJoin2188791991094245608 as (
with aggView303719871079443696 as (select v12 from aggJoin6349368325273229626 group by v12)
select title as v20 from title as t, aggView303719871079443696 where t.id=aggView303719871079443696.v12);
create or replace view aggView4583872966834630324 as select v20 from aggJoin2188791991094245608 group by v20;
select MIN(v20) as v31 from aggView4583872966834630324;
