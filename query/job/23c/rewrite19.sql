create or replace view aggJoin745330366375330891 as (
with aggView4289994724645412363 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView4289994724645412363 where mk.keyword_id=aggView4289994724645412363.v18);
create or replace view aggJoin4892320818578403240 as (
with aggView3915824250456756612 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView3915824250456756612 where mi.info_type_id=aggView3915824250456756612.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin3124903848162309007 as (
with aggView5099974305201299482 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView5099974305201299482 where mc.company_type_id=aggView5099974305201299482.v14);
create or replace view aggJoin282173935807882452 as (
with aggView6145264514945237817 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin3124903848162309007 join aggView6145264514945237817 using(v7));
create or replace view aggJoin5052106122932686135 as (
with aggView2663701744331277185 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView2663701744331277185 where cc.status_id=aggView2663701744331277185.v5);
create or replace view aggJoin5017739567215430470 as (
with aggView1797761957169651832 as (select v36 from aggJoin745330366375330891 group by v36)
select v36 from aggJoin282173935807882452 join aggView1797761957169651832 using(v36));
create or replace view aggJoin7793450116267815813 as (
with aggView3639945106347893026 as (select v36 from aggJoin5052106122932686135 group by v36)
select v36 from aggJoin5017739567215430470 join aggView3639945106347893026 using(v36));
create or replace view aggJoin1012590029508336546 as (
with aggView5044380265635595744 as (select v36 from aggJoin4892320818578403240 group by v36)
select v36 from aggJoin7793450116267815813 join aggView5044380265635595744 using(v36));
create or replace view aggJoin3243415520969257587 as (
with aggView8736960509241144580 as (select v36 from aggJoin1012590029508336546 group by v36)
select title as v37, kind_id as v21, production_year as v40 from title as t, aggView8736960509241144580 where t.id=aggView8736960509241144580.v36 and production_year>1990);
create or replace view aggView6439184671885403534 as select v37, v21 from aggJoin3243415520969257587 group by v37,v21;
create or replace view aggJoin7087955576462589747 as (
with aggView1035502323358224464 as (select id as v21, kind as v48 from kind_type as kt where kind IN ('movie','tv movie','video movie','video game'))
select v37, v48 from aggView6439184671885403534 join aggView1035502323358224464 using(v21));
select MIN(v48) as v48,MIN(v37) as v49 from aggJoin7087955576462589747;
