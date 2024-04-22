create or replace view aggJoin6337377033489641330 as (
with aggView4542996644597713559 as (select person_id as v2, MIN(name) as v55 from aka_name as an group by person_id)
select id as v2, v55 from name as n, aggView4542996644597713559 where n.id=aggView4542996644597713559.v2);
create or replace view aggJoin3401749880624980784 as (
with aggView2924816292446420864 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView2924816292446420864 where mk.keyword_id=aggView2924816292446420864.v33);
create or replace view aggJoin7897024163629395912 as (
with aggView402914740376968992 as (select v11 from aggJoin3401749880624980784 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView402914740376968992 where t.id=aggView402914740376968992.v11 and episode_nr<100);
create or replace view aggJoin9203479465510903695 as (
with aggView8022265088393823442 as (select v11, MIN(v44) as v56 from aggJoin7897024163629395912 group by v11)
select movie_id as v11, company_id as v28, v56 from movie_companies as mc, aggView8022265088393823442 where mc.movie_id=aggView8022265088393823442.v11);
create or replace view aggJoin5739955629256243540 as (
with aggView4416552683445633146 as (select id as v28 from company_name as cn where country_code= '[us]')
select v11, v56 from aggJoin9203479465510903695 join aggView4416552683445633146 using(v28));
create or replace view aggJoin2736676790194107366 as (
with aggView2490064166178591897 as (select v11, MIN(v56) as v56 from aggJoin5739955629256243540 group by v11,v56)
select person_id as v2, v56 from cast_info as ci, aggView2490064166178591897 where ci.movie_id=aggView2490064166178591897.v11);
create or replace view aggJoin4098697750241248080 as (
with aggView7087576265108240812 as (select v2, MIN(v55) as v55 from aggJoin6337377033489641330 group by v2,v55)
select v56 as v56, v55 from aggJoin2736676790194107366 join aggView7087576265108240812 using(v2));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin4098697750241248080;
