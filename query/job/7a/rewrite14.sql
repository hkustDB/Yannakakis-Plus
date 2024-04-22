create or replace view aggJoin421013525591964424 as (
with aggView7722618220344955739 as (select id as v24, name as v50 from name as n where name_pcode_cf>='A' and name LIKE 'B%' and name_pcode_cf<='F')
select person_id as v24, movie_id as v38, v50 from cast_info as ci, aggView7722618220344955739 where ci.person_id=aggView7722618220344955739.v24);
create or replace view aggJoin5544826219512814333 as (
with aggView7350355659640568634 as (select id as v38, title as v51 from title as t where production_year>=1980 and production_year<=1995)
select linked_movie_id as v38, link_type_id as v18, v51 from movie_link as ml, aggView7350355659640568634 where ml.linked_movie_id=aggView7350355659640568634.v38);
create or replace view aggJoin1108135836746810715 as (
with aggView1166033732171553413 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView1166033732171553413 where pi.info_type_id=aggView1166033732171553413.v16 and note= 'Volker Boehm');
create or replace view aggJoin1078552939404374045 as (
with aggView1543298992517973221 as (select v24 from aggJoin1108135836746810715 group by v24)
select person_id as v24, name as v3 from aka_name as an, aggView1543298992517973221 where an.person_id=aggView1543298992517973221.v24 and name LIKE '%a%');
create or replace view aggJoin3140626793422601904 as (
with aggView8750909450541213077 as (select v24 from aggJoin1078552939404374045 group by v24)
select v38, v50 as v50 from aggJoin421013525591964424 join aggView8750909450541213077 using(v24));
create or replace view aggJoin1806277013339241370 as (
with aggView5072493559967977342 as (select id as v18 from link_type as lt where link= 'features')
select v38, v51 from aggJoin5544826219512814333 join aggView5072493559967977342 using(v18));
create or replace view aggJoin332847459668780615 as (
with aggView2522320876532863405 as (select v38, MIN(v51) as v51 from aggJoin1806277013339241370 group by v38,v51)
select v50 as v50, v51 from aggJoin3140626793422601904 join aggView2522320876532863405 using(v38));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin332847459668780615;
