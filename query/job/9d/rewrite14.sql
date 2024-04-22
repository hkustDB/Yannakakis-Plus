create or replace view aggView9144734235744564778 as select person_id as v35, name as v3 from aka_name as an group by person_id,name;
create or replace view aggView1932156460244267765 as select id as v9, name as v10 from char_name as chn;
create or replace view aggView8338102890822026532 as select name as v36, id as v35 from name as n where gender= 'f';
create or replace view aggJoin7505732560211067972 as (
with aggView5095222971855940598 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView5095222971855940598 where mc.company_id=aggView5095222971855940598.v32);
create or replace view aggJoin2039484495303301683 as (
with aggView7840207222308627171 as (select v18 from aggJoin7505732560211067972 group by v18)
select id as v18, title as v47 from title as t, aggView7840207222308627171 where t.id=aggView7840207222308627171.v18);
create or replace view aggView8606844760296800023 as select v18, v47 from aggJoin2039484495303301683 group by v18,v47;
create or replace view aggJoin6948001571663357888 as (
with aggView778926079156516882 as (select v35, MIN(v3) as v58 from aggView9144734235744564778 group by v35)
select person_id as v35, movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v58 from cast_info as ci, aggView778926079156516882 where ci.person_id=aggView778926079156516882.v35 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin8412453877353744353 as (
with aggView3276144176351611249 as (select v18, MIN(v47) as v61 from aggView8606844760296800023 group by v18)
select v35, v9, v20, v22, v58 as v58, v61 from aggJoin6948001571663357888 join aggView3276144176351611249 using(v18));
create or replace view aggJoin8308156982826310494 as (
with aggView2115568193894205116 as (select v35, MIN(v36) as v60 from aggView8338102890822026532 group by v35)
select v9, v20, v22, v58 as v58, v61 as v61, v60 from aggJoin8412453877353744353 join aggView2115568193894205116 using(v35));
create or replace view aggJoin6644229972712321454 as (
with aggView7601617787292523743 as (select id as v22 from role_type as rt where role= 'actress')
select v9, v20, v58, v61, v60 from aggJoin8308156982826310494 join aggView7601617787292523743 using(v22));
create or replace view aggJoin3067447074418913706 as (
with aggView8476118351414766636 as (select v9, MIN(v58) as v58, MIN(v61) as v61, MIN(v60) as v60 from aggJoin6644229972712321454 group by v9,v60,v58,v61)
select v10, v58, v61, v60 from aggView1932156460244267765 join aggView8476118351414766636 using(v9));
select MIN(v58) as v58,MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin3067447074418913706;
