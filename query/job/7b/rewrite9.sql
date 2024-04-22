create or replace view aggJoin2799072251206808850 as (
with aggView4012733450881414541 as (select id as v24, name as v50 from name as n where gender= 'm' and name_pcode_cf LIKE 'D%')
select person_id as v24, name as v3, v50 from aka_name as an, aggView4012733450881414541 where an.person_id=aggView4012733450881414541.v24 and name LIKE '%a%');
create or replace view aggJoin9195966101709569216 as (
with aggView5209482989124405595 as (select id as v38, title as v51 from title as t where production_year<=1984 and production_year>=1980)
select linked_movie_id as v38, link_type_id as v18, v51 from movie_link as ml, aggView5209482989124405595 where ml.linked_movie_id=aggView5209482989124405595.v38);
create or replace view aggJoin4929981008218105603 as (
with aggView6262853558594147712 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView6262853558594147712 where pi.info_type_id=aggView6262853558594147712.v16 and note= 'Volker Boehm');
create or replace view aggJoin6183604949920464954 as (
with aggView4766678758166593386 as (select id as v18 from link_type as lt where link= 'features')
select v38, v51 from aggJoin9195966101709569216 join aggView4766678758166593386 using(v18));
create or replace view aggJoin5269201045702722815 as (
with aggView8484303556012012443 as (select v38, MIN(v51) as v51 from aggJoin6183604949920464954 group by v38,v51)
select person_id as v24, v51 from cast_info as ci, aggView8484303556012012443 where ci.movie_id=aggView8484303556012012443.v38);
create or replace view aggJoin8901107665113275495 as (
with aggView7539348965971053045 as (select v24, MIN(v50) as v50 from aggJoin2799072251206808850 group by v24,v50)
select v24, v37, v50 from aggJoin4929981008218105603 join aggView7539348965971053045 using(v24));
create or replace view aggJoin6065065977303494680 as (
with aggView6378262257882776909 as (select v24, MIN(v50) as v50 from aggJoin8901107665113275495 group by v24,v50)
select v51 as v51, v50 from aggJoin5269201045702722815 join aggView6378262257882776909 using(v24));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin6065065977303494680;
