create or replace view aggJoin1084405158533844329 as (
with aggView6982370456726127648 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView6982370456726127648 where mc.company_id=aggView6982370456726127648.v20);
create or replace view aggJoin6104361701545966180 as (
with aggView2795933905629428910 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView2795933905629428910 where mk.keyword_id=aggView2795933905629428910.v25);
create or replace view aggJoin4400434106240958263 as (
with aggView6845267930595362429 as (select id as v3 from title as t)
select v3 from aggJoin6104361701545966180 join aggView6845267930595362429 using(v3));
create or replace view aggJoin8054053896479165521 as (
with aggView2957098099896153760 as (select v3 from aggJoin4400434106240958263 group by v3)
select v3 from aggJoin1084405158533844329 join aggView2957098099896153760 using(v3));
create or replace view aggJoin374065318869476662 as (
with aggView9645118224404309 as (select v3 from aggJoin8054053896479165521 group by v3)
select person_id as v26 from cast_info as ci, aggView9645118224404309 where ci.movie_id=aggView9645118224404309.v3);
create or replace view aggJoin1951721763950054751 as (
with aggView7526440963873732352 as (select v26 from aggJoin374065318869476662 group by v26)
select name as v27 from name as n, aggView7526440963873732352 where n.id=aggView7526440963873732352.v26);
create or replace view aggView2643453115421427242 as select v27 from aggJoin1951721763950054751 group by v27;
select MIN(v27) as v47 from aggView2643453115421427242;
