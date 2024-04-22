create or replace view aggView3596336574480111031 as select person_id as v2, name as v3 from aka_name as an group by person_id,name;
create or replace view aggJoin7988114139981525720 as (
with aggView1751733557407191857 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView1751733557407191857 where mc.company_id=aggView1751733557407191857.v28);
create or replace view aggJoin7241845691135675581 as (
with aggView6752993782277813314 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView6752993782277813314 where mk.keyword_id=aggView6752993782277813314.v33);
create or replace view aggJoin4792304458259797563 as (
with aggView3384063213218275075 as (select v11 from aggJoin7988114139981525720 group by v11)
select v11 from aggJoin7241845691135675581 join aggView3384063213218275075 using(v11));
create or replace view aggJoin7785487278941551306 as (
with aggView8731151299497982288 as (select v11 from aggJoin4792304458259797563 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView8731151299497982288 where t.id=aggView8731151299497982288.v11 and episode_nr>=5 and episode_nr<100);
create or replace view aggView4617313404293727638 as select v44, v11 from aggJoin7785487278941551306 group by v44,v11;
create or replace view aggJoin5433746083217062872 as (
with aggView5840779487943406395 as (select v2, MIN(v3) as v55 from aggView3596336574480111031 group by v2)
select person_id as v2, movie_id as v11, v55 from cast_info as ci, aggView5840779487943406395 where ci.person_id=aggView5840779487943406395.v2);
create or replace view aggJoin5206569273521004646 as (
with aggView368645134780408721 as (select id as v2 from name as n)
select v11, v55 from aggJoin5433746083217062872 join aggView368645134780408721 using(v2));
create or replace view aggJoin504604463535384687 as (
with aggView285343540533523303 as (select v11, MIN(v55) as v55 from aggJoin5206569273521004646 group by v11,v55)
select v44, v55 from aggView4617313404293727638 join aggView285343540533523303 using(v11));
select MIN(v55) as v55,MIN(v44) as v56 from aggJoin504604463535384687;
