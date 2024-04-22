create or replace view aggView7135623486374106532 as select name as v9, id as v8 from company_name as cn2;
create or replace view aggView5371365577439975242 as select id as v1, name as v2 from company_name as cn1 where country_code= '[nl]';
create or replace view aggJoin7898882727631847571 as (
with aggView2870204047244787634 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView2870204047244787634 where mi_idx1.info_type_id=aggView2870204047244787634.v15);
create or replace view aggView2493087194068547193 as select v49, v38 from aggJoin7898882727631847571 group by v49,v38;
create or replace view aggJoin202975653500310623 as (
with aggView8001718029537654012 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView8001718029537654012 where mi_idx2.info_type_id=aggView8001718029537654012.v17 and info<'3.0');
create or replace view aggView3936701330499106187 as select v61, v43 from aggJoin202975653500310623 group by v61,v43;
create or replace view aggJoin2663090555044281751 as (
with aggView5285435404282924787 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView5285435404282924787 where t1.kind_id=aggView5285435404282924787.v19);
create or replace view aggView371384215041022491 as select v50, v49 from aggJoin2663090555044281751 group by v50,v49;
create or replace view aggJoin3933808180137464401 as (
with aggView1031646737461749358 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView1031646737461749358 where t2.kind_id=aggView1031646737461749358.v21 and production_year= 2007);
create or replace view aggView2936078733640514645 as select v62, v61 from aggJoin3933808180137464401 group by v62,v61;
create or replace view aggJoin5783521046984584404 as (
with aggView4089779472505824827 as (select v49, MIN(v50) as v77 from aggView371384215041022491 group by v49)
select movie_id as v49, company_id as v1, v77 from movie_companies as mc1, aggView4089779472505824827 where mc1.movie_id=aggView4089779472505824827.v49);
create or replace view aggJoin3198330903430466375 as (
with aggView151884181836141412 as (select v8, MIN(v9) as v74 from aggView7135623486374106532 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView151884181836141412 where mc2.company_id=aggView151884181836141412.v8);
create or replace view aggJoin4415378962917285226 as (
with aggView7429672995219175416 as (select v1, MIN(v2) as v73 from aggView5371365577439975242 group by v1)
select v49, v77 as v77, v73 from aggJoin5783521046984584404 join aggView7429672995219175416 using(v1));
create or replace view aggJoin2881181284168222533 as (
with aggView6099376565218125466 as (select v61, MIN(v74) as v74 from aggJoin3198330903430466375 group by v61,v74)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v74 from movie_link as ml, aggView6099376565218125466 where ml.linked_movie_id=aggView6099376565218125466.v61);
create or replace view aggJoin7585172716593609592 as (
with aggView2992589648755061782 as (select v49, MIN(v77) as v77, MIN(v73) as v73 from aggJoin4415378962917285226 group by v49,v73,v77)
select v49, v38, v77, v73 from aggView2493087194068547193 join aggView2992589648755061782 using(v49));
create or replace view aggJoin3866266495062666949 as (
with aggView7567238830667651113 as (select v49, MIN(v77) as v77, MIN(v73) as v73, MIN(v38) as v75 from aggJoin7585172716593609592 group by v49,v73,v77)
select v61, v23, v74 as v74, v77, v73, v75 from aggJoin2881181284168222533 join aggView7567238830667651113 using(v49));
create or replace view aggJoin2231507289860916490 as (
with aggView7379842399509147423 as (select id as v23 from link_type as lt where link LIKE '%follow%')
select v61, v74, v77, v73, v75 from aggJoin3866266495062666949 join aggView7379842399509147423 using(v23));
create or replace view aggJoin7061657694922339971 as (
with aggView5473077725616431974 as (select v61, MIN(v74) as v74, MIN(v77) as v77, MIN(v73) as v73, MIN(v75) as v75 from aggJoin2231507289860916490 group by v61,v74,v75,v77,v73)
select v61, v43, v74, v77, v73, v75 from aggView3936701330499106187 join aggView5473077725616431974 using(v61));
create or replace view aggJoin4821107601765834765 as (
with aggView429317739271446028 as (select v61, MIN(v74) as v74, MIN(v77) as v77, MIN(v73) as v73, MIN(v75) as v75, MIN(v43) as v76 from aggJoin7061657694922339971 group by v61,v74,v75,v77,v73)
select v62, v74, v77, v73, v75, v76 from aggView2936078733640514645 join aggView429317739271446028 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v62) as v78 from aggJoin4821107601765834765;
