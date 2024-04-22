create or replace view aggJoin2068046921277353760 as (
with aggView7503710933813348453 as (select person_id as v2, MIN(name) as v55 from aka_name as an group by person_id)
select id as v2, v55 from name as n, aggView7503710933813348453 where n.id=aggView7503710933813348453.v2);
create or replace view aggJoin4934032299697830682 as (
with aggView2523095335185996030 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView2523095335185996030 where mc.company_id=aggView2523095335185996030.v28);
create or replace view aggJoin2882305059001042770 as (
with aggView7772723978329808783 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView7772723978329808783 where mk.keyword_id=aggView7772723978329808783.v33);
create or replace view aggJoin1538047168337047251 as (
with aggView5502650328192047278 as (select v2, MIN(v55) as v55 from aggJoin2068046921277353760 group by v2,v55)
select movie_id as v11, v55 from cast_info as ci, aggView5502650328192047278 where ci.person_id=aggView5502650328192047278.v2);
create or replace view aggJoin4654501740596602274 as (
with aggView3781432981821646564 as (select v11 from aggJoin4934032299697830682 group by v11)
select id as v11, title as v44 from title as t, aggView3781432981821646564 where t.id=aggView3781432981821646564.v11);
create or replace view aggJoin6359365810952197749 as (
with aggView4159735105328409531 as (select v11, MIN(v44) as v56 from aggJoin4654501740596602274 group by v11)
select v11, v55 as v55, v56 from aggJoin1538047168337047251 join aggView4159735105328409531 using(v11));
create or replace view aggJoin3425509230706774526 as (
with aggView6564530592642684072 as (select v11 from aggJoin2882305059001042770 group by v11)
select v55 as v55, v56 as v56 from aggJoin6359365810952197749 join aggView6564530592642684072 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin3425509230706774526;
