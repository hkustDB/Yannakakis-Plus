create or replace view aggView225316208764584514 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggJoin4155085544785124529 as (
with aggView2471941947996346466 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView2471941947996346466 where mi.info_type_id=aggView2471941947996346466.v8 and info= 'Horror');
create or replace view aggView4506098947962596725 as select v18, v37 from aggJoin4155085544785124529 group by v18,v37;
create or replace view aggJoin1138684407920124364 as (
with aggView1169437648693905672 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView1169437648693905672 where mk.keyword_id=aggView1169437648693905672.v12);
create or replace view aggJoin3278479081062203842 as (
with aggView129892173730824962 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView129892173730824962 where mi_idx.info_type_id=aggView129892173730824962.v10);
create or replace view aggView4071651939505224629 as select v23, v37 from aggJoin3278479081062203842 group by v23,v37;
create or replace view aggJoin8715444385362634990 as (
with aggView1549526436873881789 as (select v37 from aggJoin1138684407920124364 group by v37)
select id as v37, title as v38, production_year as v41 from title as t, aggView1549526436873881789 where t.id=aggView1549526436873881789.v37 and production_year>2010 and title LIKE 'Vampire%');
create or replace view aggView2484394917170378581 as select v38, v37 from aggJoin8715444385362634990 group by v38,v37;
create or replace view aggJoin6213233904723543561 as (
with aggView8461068325566822603 as (select v28, MIN(v29) as v51 from aggView225316208764584514 group by v28)
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView8461068325566822603 where ci.person_id=aggView8461068325566822603.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin4935494321824559703 as (
with aggView6787801398465669582 as (select v37, MIN(v51) as v51 from aggJoin6213233904723543561 group by v37,v51)
select v38, v37, v51 from aggView2484394917170378581 join aggView6787801398465669582 using(v37));
create or replace view aggJoin1751038169850527379 as (
with aggView8502335991693409200 as (select v37, MIN(v51) as v51, MIN(v38) as v52 from aggJoin4935494321824559703 group by v37,v51)
select v18, v37, v51, v52 from aggView4506098947962596725 join aggView8502335991693409200 using(v37));
create or replace view aggJoin5012783375773660097 as (
with aggView6544463716334023006 as (select v37, MIN(v51) as v51, MIN(v52) as v52, MIN(v18) as v49 from aggJoin1751038169850527379 group by v37,v51,v52)
select v23, v51, v52, v49 from aggView4071651939505224629 join aggView6544463716334023006 using(v37));
select MIN(v49) as v49,MIN(v23) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin5012783375773660097;
