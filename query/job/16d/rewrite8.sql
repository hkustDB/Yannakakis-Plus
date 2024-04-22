create or replace view aggJoin4040948457378534720 as (
with aggView5841541578739454801 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView5841541578739454801 where mc.company_id=aggView5841541578739454801.v28);
create or replace view aggJoin6960456019533123840 as (
with aggView1247026214966618560 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView1247026214966618560 where mk.keyword_id=aggView1247026214966618560.v33);
create or replace view aggJoin1200195076590331432 as (
with aggView6400346313459919833 as (select v11 from aggJoin6960456019533123840 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView6400346313459919833 where t.id=aggView6400346313459919833.v11 and episode_nr>=5 and episode_nr<100);
create or replace view aggJoin6595522547990388018 as (
with aggView5593581862434777961 as (select v11, MIN(v44) as v56 from aggJoin1200195076590331432 group by v11)
select v11, v56 from aggJoin4040948457378534720 join aggView5593581862434777961 using(v11));
create or replace view aggJoin1644449248170739939 as (
with aggView5774024481790232263 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView5774024481790232263 where an.person_id=aggView5774024481790232263.v2);
create or replace view aggJoin3453172058988626334 as (
with aggView852908306577031031 as (select v2, MIN(v3) as v55 from aggJoin1644449248170739939 group by v2)
select movie_id as v11, v55 from cast_info as ci, aggView852908306577031031 where ci.person_id=aggView852908306577031031.v2);
create or replace view aggJoin3107721170730347006 as (
with aggView3704099264031586744 as (select v11, MIN(v56) as v56 from aggJoin6595522547990388018 group by v11,v56)
select v55 as v55, v56 from aggJoin3453172058988626334 join aggView3704099264031586744 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin3107721170730347006;
