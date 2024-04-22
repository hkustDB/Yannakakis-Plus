create or replace view aggView1538248583613915549 as select name as v3, person_id as v35 from aka_name as an group by name,person_id;
create or replace view aggJoin1195595035079261609 as (
with aggView8685376471670796708 as (select name as v36, id as v35 from name as n where gender= 'f')
select v35, v36 from aggView8685376471670796708 where v36 LIKE '%Angel%');
create or replace view aggView2341494637882779467 as select id as v9, name as v10 from char_name as chn;
create or replace view aggJoin4000463455121530571 as (
with aggView7924961996199779878 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18, note as v34 from movie_companies as mc, aggView7924961996199779878 where mc.company_id=aggView7924961996199779878.v32 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin3593189145015759990 as (
with aggView2160789170378407521 as (select v18 from aggJoin4000463455121530571 group by v18)
select id as v18, title as v47, production_year as v50 from title as t, aggView2160789170378407521 where t.id=aggView2160789170378407521.v18 and production_year>=2007 and production_year<=2010);
create or replace view aggView4741151417491781229 as select v47, v18 from aggJoin3593189145015759990 group by v47,v18;
create or replace view aggJoin3169013364956341954 as (
with aggView182480592695276802 as (select v35, MIN(v36) as v60 from aggJoin1195595035079261609 group by v35)
select v3, v35, v60 from aggView1538248583613915549 join aggView182480592695276802 using(v35));
create or replace view aggJoin5035083144442417060 as (
with aggView425666995502241269 as (select v35, MIN(v60) as v60, MIN(v3) as v58 from aggJoin3169013364956341954 group by v35,v60)
select movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v60, v58 from cast_info as ci, aggView425666995502241269 where ci.person_id=aggView425666995502241269.v35 and note= '(voice)');
create or replace view aggJoin1942056656906639972 as (
with aggView6037131815665120502 as (select v18, MIN(v47) as v61 from aggView4741151417491781229 group by v18)
select v9, v20, v22, v60 as v60, v58 as v58, v61 from aggJoin5035083144442417060 join aggView6037131815665120502 using(v18));
create or replace view aggJoin2601141409187003898 as (
with aggView1049010948852805843 as (select id as v22 from role_type as rt where role= 'actress')
select v9, v20, v60, v58, v61 from aggJoin1942056656906639972 join aggView1049010948852805843 using(v22));
create or replace view aggJoin6658561708060667128 as (
with aggView2788170002969112774 as (select v9, MIN(v60) as v60, MIN(v58) as v58, MIN(v61) as v61 from aggJoin2601141409187003898 group by v9,v58,v60,v61)
select v10, v60, v58, v61 from aggView2341494637882779467 join aggView2788170002969112774 using(v9));
select MIN(v58) as v58,MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin6658561708060667128;
