create or replace view aggView4031320901726194677 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin6778848582406891982 as (
with aggView1730353442789304177 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView1730353442789304177 where mi_idx.info_type_id=aggView1730353442789304177.v20 and info>'6.5');
create or replace view aggView2135178060129355490 as select v45, v40 from aggJoin6778848582406891982 group by v45,v40;
create or replace view aggJoin2752264127132367414 as (
with aggView3200398265210249182 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView3200398265210249182 where t.kind_id=aggView3200398265210249182.v25 and production_year>2005);
create or replace view aggView3458788751758489169 as select v46, v45 from aggJoin2752264127132367414 group by v46,v45;
create or replace view aggJoin8669450695898251439 as (
with aggView4386491126437010733 as (select v9, MIN(v10) as v57 from aggView4031320901726194677 group by v9)
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView4386491126437010733 where mc.company_id=aggView4386491126437010733.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin3314656211061752501 as (
with aggView5852000643694197071 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView5852000643694197071 where cc.status_id=aggView5852000643694197071.v7);
create or replace view aggJoin7662298400537397141 as (
with aggView1235210260795761830 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin8669450695898251439 join aggView1235210260795761830 using(v16));
create or replace view aggJoin2131742993018849417 as (
with aggView3895199533678584403 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin3314656211061752501 join aggView3895199533678584403 using(v5));
create or replace view aggJoin5232772582397376095 as (
with aggView6683496874114241466 as (select v45 from aggJoin2131742993018849417 group by v45)
select movie_id as v45, info_type_id as v18, info as v35 from movie_info as mi, aggView6683496874114241466 where mi.movie_id=aggView6683496874114241466.v45 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin405479894976306569 as (
with aggView7077376225792532415 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35 from aggJoin5232772582397376095 join aggView7077376225792532415 using(v18));
create or replace view aggJoin2834764369908170386 as (
with aggView7679203089391147687 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView7679203089391147687 where mk.keyword_id=aggView7679203089391147687.v22);
create or replace view aggJoin3014621917112089393 as (
with aggView202710958169149468 as (select v45 from aggJoin2834764369908170386 group by v45)
select v45, v31, v57 as v57 from aggJoin7662298400537397141 join aggView202710958169149468 using(v45));
create or replace view aggJoin7359395822084104619 as (
with aggView5388071428752543643 as (select v45 from aggJoin405479894976306569 group by v45)
select v45, v31, v57 as v57 from aggJoin3014621917112089393 join aggView5388071428752543643 using(v45));
create or replace view aggJoin7072892679900796958 as (
with aggView556980768241286429 as (select v45, MIN(v57) as v57 from aggJoin7359395822084104619 group by v45,v57)
select v46, v45, v57 from aggView3458788751758489169 join aggView556980768241286429 using(v45));
create or replace view aggJoin7537008667509002752 as (
with aggView2742348971562954209 as (select v45, MIN(v57) as v57, MIN(v46) as v59 from aggJoin7072892679900796958 group by v45,v57)
select v40, v57, v59 from aggView2135178060129355490 join aggView2742348971562954209 using(v45));
select MIN(v57) as v57,MIN(v40) as v58,MIN(v59) as v59 from aggJoin7537008667509002752;
