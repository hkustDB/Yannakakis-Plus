create or replace view aggView9005023934425662143 as select person_id as v2, name as v3 from aka_name as an group by person_id,name;
create or replace view aggJoin4615201200716320539 as (
with aggView1641328372736359970 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView1641328372736359970 where mk.keyword_id=aggView1641328372736359970.v33);
create or replace view aggJoin2531240517017628569 as (
with aggView8566090600510306343 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView8566090600510306343 where mc.company_id=aggView8566090600510306343.v28);
create or replace view aggJoin5813818030387647279 as (
with aggView1740100098923569546 as (select v11 from aggJoin4615201200716320539 group by v11)
select v11 from aggJoin2531240517017628569 join aggView1740100098923569546 using(v11));
create or replace view aggJoin2395427890297758112 as (
with aggView6069072175307432442 as (select v11 from aggJoin5813818030387647279 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView6069072175307432442 where t.id=aggView6069072175307432442.v11 and episode_nr>=50 and episode_nr<100);
create or replace view aggView6145704355292387998 as select v11, v44 from aggJoin2395427890297758112 group by v11,v44;
create or replace view aggJoin7463104958239976012 as (
with aggView3157509073201117716 as (select v11, MIN(v44) as v56 from aggView6145704355292387998 group by v11)
select person_id as v2, v56 from cast_info as ci, aggView3157509073201117716 where ci.movie_id=aggView3157509073201117716.v11);
create or replace view aggJoin394445497167566581 as (
with aggView80078269791156542 as (select id as v2 from name as n)
select v2, v56 from aggJoin7463104958239976012 join aggView80078269791156542 using(v2));
create or replace view aggJoin76504720033053502 as (
with aggView8880264780463587789 as (select v2, MIN(v56) as v56 from aggJoin394445497167566581 group by v2,v56)
select v3, v56 from aggView9005023934425662143 join aggView8880264780463587789 using(v2));
select MIN(v3) as v55,MIN(v56) as v56 from aggJoin76504720033053502;
