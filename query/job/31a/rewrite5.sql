create or replace view aggView454409549742398502 as select name as v41, id as v40 from name as n where gender= 'm';
create or replace view aggJoin398204926306205863 as (
with aggView8375084691178696870 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView8375084691178696870 where mk.keyword_id=aggView8375084691178696870.v19);
create or replace view aggJoin6923967069534546225 as (
with aggView4608969408263384740 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView4608969408263384740 where mi_idx.info_type_id=aggView4608969408263384740.v17);
create or replace view aggJoin5907985534148234864 as (
with aggView3008947954368624532 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView3008947954368624532 where mc.company_id=aggView3008947954368624532.v8);
create or replace view aggJoin6758132215895777798 as (
with aggView1795749179203809279 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView1795749179203809279 where mi.info_type_id=aggView1795749179203809279.v15);
create or replace view aggJoin5494156464476301438 as (
with aggView3580447598480305548 as (select v30, v49 from aggJoin6758132215895777798 group by v30,v49)
select v49, v30 from aggView3580447598480305548 where v30 IN ('Horror','Thriller'));
create or replace view aggJoin8772718371392419104 as (
with aggView5451915404481934368 as (select v49 from aggJoin398204926306205863 group by v49)
select v49, v35 from aggJoin6923967069534546225 join aggView5451915404481934368 using(v49));
create or replace view aggView614309452920770041 as select v49, v35 from aggJoin8772718371392419104 group by v49,v35;
create or replace view aggJoin5284579819569510726 as (
with aggView4197903720562954406 as (select v49 from aggJoin5907985534148234864 group by v49)
select id as v49, title as v50 from title as t, aggView4197903720562954406 where t.id=aggView4197903720562954406.v49);
create or replace view aggView5007278752262805398 as select v50, v49 from aggJoin5284579819569510726 group by v50,v49;
create or replace view aggJoin1739776315292126047 as (
with aggView3460875849784879297 as (select v40, MIN(v41) as v63 from aggView454409549742398502 group by v40)
select movie_id as v49, note as v5, v63 from cast_info as ci, aggView3460875849784879297 where ci.person_id=aggView3460875849784879297.v40 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin5938949384441351937 as (
with aggView1045242305079799178 as (select v49, MIN(v30) as v61 from aggJoin5494156464476301438 group by v49)
select v49, v35, v61 from aggView614309452920770041 join aggView1045242305079799178 using(v49));
create or replace view aggJoin4664464778519381802 as (
with aggView8804843633542457873 as (select v49, MIN(v63) as v63 from aggJoin1739776315292126047 group by v49,v63)
select v50, v49, v63 from aggView5007278752262805398 join aggView8804843633542457873 using(v49));
create or replace view aggJoin5883459626918271943 as (
with aggView3462436700004395518 as (select v49, MIN(v63) as v63, MIN(v50) as v64 from aggJoin4664464778519381802 group by v49,v63)
select v35, v61 as v61, v63, v64 from aggJoin5938949384441351937 join aggView3462436700004395518 using(v49));
select MIN(v61) as v61,MIN(v35) as v62,MIN(v63) as v63,MIN(v64) as v64 from aggJoin5883459626918271943;
