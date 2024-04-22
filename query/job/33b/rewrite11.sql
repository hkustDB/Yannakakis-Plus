create or replace view aggJoin6478039801065464056 as (
with aggView1663404487616987396 as (select id as v1, name as v73 from company_name as cn1 where country_code= '[nl]')
select movie_id as v49, v73 from movie_companies as mc1, aggView1663404487616987396 where mc1.company_id=aggView1663404487616987396.v1);
create or replace view aggJoin8636694731516841956 as (
with aggView5584122174670965915 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView5584122174670965915 where mc2.company_id=aggView5584122174670965915.v8);
create or replace view aggJoin648375602382751597 as (
with aggView6195204285505517322 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView6195204285505517322 where mi_idx1.info_type_id=aggView6195204285505517322.v15);
create or replace view aggJoin6850872940721073537 as (
with aggView6398226403754963838 as (select v61, MIN(v74) as v74 from aggJoin8636694731516841956 group by v61,v74)
select movie_id as v61, info_type_id as v17, info as v43, v74 from movie_info_idx as mi_idx2, aggView6398226403754963838 where mi_idx2.movie_id=aggView6398226403754963838.v61 and info<'3.0');
create or replace view aggJoin4816223499519254941 as (
with aggView5849950379708170330 as (select id as v23 from link_type as lt where link LIKE '%follow%')
select movie_id as v49, linked_movie_id as v61 from movie_link as ml, aggView5849950379708170330 where ml.link_type_id=aggView5849950379708170330.v23);
create or replace view aggJoin6748723431738201316 as (
with aggView1629721364836390495 as (select id as v17 from info_type as it2 where info= 'rating')
select v61, v43, v74 from aggJoin6850872940721073537 join aggView1629721364836390495 using(v17));
create or replace view aggJoin557292204443087392 as (
with aggView3720358585681199215 as (select v61, MIN(v74) as v74, MIN(v43) as v76 from aggJoin6748723431738201316 group by v61,v74)
select v49, v61, v74, v76 from aggJoin4816223499519254941 join aggView3720358585681199215 using(v61));
create or replace view aggJoin8501667928890801349 as (
with aggView8022454112002118923 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView8022454112002118923 where t2.kind_id=aggView8022454112002118923.v21 and production_year= 2007);
create or replace view aggJoin450845986274824737 as (
with aggView5487700785227225285 as (select v61, MIN(v62) as v78 from aggJoin8501667928890801349 group by v61)
select v49, v74 as v74, v76 as v76, v78 from aggJoin557292204443087392 join aggView5487700785227225285 using(v61));
create or replace view aggJoin6535102992245323321 as (
with aggView3689560775480760363 as (select v49, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78 from aggJoin450845986274824737 group by v49,v74,v78,v76)
select v49, v38, v74, v76, v78 from aggJoin648375602382751597 join aggView3689560775480760363 using(v49));
create or replace view aggJoin7577705664356751980 as (
with aggView6140373364737830913 as (select v49, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78, MIN(v38) as v75 from aggJoin6535102992245323321 group by v49,v74,v78,v76)
select id as v49, title as v50, kind_id as v19, v74, v76, v78, v75 from title as t1, aggView6140373364737830913 where t1.id=aggView6140373364737830913.v49);
create or replace view aggJoin874013622220662046 as (
with aggView459745390680999610 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select v49, v50, v74, v76, v78, v75 from aggJoin7577705664356751980 join aggView459745390680999610 using(v19));
create or replace view aggJoin3568618832369538314 as (
with aggView7824362341028971693 as (select v49, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78, MIN(v75) as v75, MIN(v50) as v77 from aggJoin874013622220662046 group by v49,v74,v78,v75,v76)
select v73 as v73, v74, v76, v78, v75, v77 from aggJoin6478039801065464056 join aggView7824362341028971693 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin3568618832369538314;
