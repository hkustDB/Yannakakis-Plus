create or replace view aggView1946286088164667313 as select name as v3, person_id as v35 from aka_name as an group by name,person_id;
create or replace view aggJoin3476677496774274800 as (
with aggView4803670016652130073 as (select name as v36, id as v35 from name as n where gender= 'f')
select v35, v36 from aggView4803670016652130073 where v36 LIKE '%Angel%');
create or replace view aggView3367252158037114707 as select id as v9, name as v10 from char_name as chn;
create or replace view aggJoin6526181664117073892 as (
with aggView2053853258462235264 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18, note as v34 from movie_companies as mc, aggView2053853258462235264 where mc.company_id=aggView2053853258462235264.v32 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin3489316792376617135 as (
with aggView115818613569959296 as (select v18 from aggJoin6526181664117073892 group by v18)
select id as v18, title as v47, production_year as v50 from title as t, aggView115818613569959296 where t.id=aggView115818613569959296.v18 and production_year>=2007 and production_year<=2010);
create or replace view aggView1434004674685424134 as select v47, v18 from aggJoin3489316792376617135 group by v47,v18;
create or replace view aggJoin3258551868638907295 as (
with aggView90195654466892501 as (select v9, MIN(v10) as v59 from aggView3367252158037114707 group by v9)
select person_id as v35, movie_id as v18, note as v20, role_id as v22, v59 from cast_info as ci, aggView90195654466892501 where ci.person_role_id=aggView90195654466892501.v9 and note= '(voice)');
create or replace view aggJoin2552954919382068357 as (
with aggView4349418146949393072 as (select v18, MIN(v47) as v61 from aggView1434004674685424134 group by v18)
select v35, v20, v22, v59 as v59, v61 from aggJoin3258551868638907295 join aggView4349418146949393072 using(v18));
create or replace view aggJoin6787128887311008400 as (
with aggView3497955753264110157 as (select id as v22 from role_type as rt where role= 'actress')
select v35, v20, v59, v61 from aggJoin2552954919382068357 join aggView3497955753264110157 using(v22));
create or replace view aggJoin7014958565173177208 as (
with aggView8168125006863431726 as (select v35, MIN(v59) as v59, MIN(v61) as v61 from aggJoin6787128887311008400 group by v35,v59,v61)
select v35, v36, v59, v61 from aggJoin3476677496774274800 join aggView8168125006863431726 using(v35));
create or replace view aggJoin8392776128327656125 as (
with aggView3707685357902707869 as (select v35, MIN(v59) as v59, MIN(v61) as v61, MIN(v36) as v60 from aggJoin7014958565173177208 group by v35,v59,v61)
select v3, v59, v61, v60 from aggView1946286088164667313 join aggView3707685357902707869 using(v35));
select MIN(v3) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin8392776128327656125;
