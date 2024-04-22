create or replace view aggView944533117355068630 as select id as v8, name as v9 from company_name as cn2;
create or replace view aggView8397104294011681649 as select id as v1, name as v2 from company_name as cn1 where country_code= '[us]';
create or replace view aggJoin1380717955258957702 as (
with aggView7413055667007273514 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView7413055667007273514 where t1.kind_id=aggView7413055667007273514.v19);
create or replace view aggView3438551377413886641 as select v49, v50 from aggJoin1380717955258957702 group by v49,v50;
create or replace view aggJoin4001814440374491464 as (
with aggView8422307528040203026 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView8422307528040203026 where t2.kind_id=aggView8422307528040203026.v21 and production_year<=2008 and production_year>=2005);
create or replace view aggView7837924285058591955 as select v61, v62 from aggJoin4001814440374491464 group by v61,v62;
create or replace view aggJoin6788274157861966817 as (
with aggView50583223017955719 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView50583223017955719 where mi_idx2.info_type_id=aggView50583223017955719.v17 and info<'3.0');
create or replace view aggView230944923672607698 as select v61, v43 from aggJoin6788274157861966817 group by v61,v43;
create or replace view aggJoin7416928448580092981 as (
with aggView6970758113337399798 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView6970758113337399798 where mi_idx1.info_type_id=aggView6970758113337399798.v15);
create or replace view aggView1936077226180115175 as select v49, v38 from aggJoin7416928448580092981 group by v49,v38;
create or replace view aggJoin4479052649925736066 as (
with aggView2285140092915065417 as (select v8, MIN(v9) as v74 from aggView944533117355068630 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView2285140092915065417 where mc2.company_id=aggView2285140092915065417.v8);
create or replace view aggJoin1472266757116827505 as (
with aggView240304082383523867 as (select v1, MIN(v2) as v73 from aggView8397104294011681649 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView240304082383523867 where mc1.company_id=aggView240304082383523867.v1);
create or replace view aggJoin8110461901495491926 as (
with aggView1502677724963358621 as (select v49, MIN(v50) as v77 from aggView3438551377413886641 group by v49)
select v49, v73 as v73, v77 from aggJoin1472266757116827505 join aggView1502677724963358621 using(v49));
create or replace view aggJoin5854046365650465683 as (
with aggView1688166897618479683 as (select v61, MIN(v62) as v78 from aggView7837924285058591955 group by v61)
select v61, v74 as v74, v78 from aggJoin4479052649925736066 join aggView1688166897618479683 using(v61));
create or replace view aggJoin8728812496983529326 as (
with aggView9099296537892429902 as (select v49, MIN(v73) as v73, MIN(v77) as v77 from aggJoin8110461901495491926 group by v49,v77,v73)
select v49, v38, v73, v77 from aggView1936077226180115175 join aggView9099296537892429902 using(v49));
create or replace view aggJoin3604576268595141574 as (
with aggView3044086210328413440 as (select v49, MIN(v73) as v73, MIN(v77) as v77, MIN(v38) as v75 from aggJoin8728812496983529326 group by v49,v77,v73)
select linked_movie_id as v61, link_type_id as v23, v73, v77, v75 from movie_link as ml, aggView3044086210328413440 where ml.movie_id=aggView3044086210328413440.v49);
create or replace view aggJoin781083446743269670 as (
with aggView1065142781884579046 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v61, v73, v77, v75 from aggJoin3604576268595141574 join aggView1065142781884579046 using(v23));
create or replace view aggJoin8230046932352495310 as (
with aggView4500775274086110488 as (select v61, MIN(v74) as v74, MIN(v78) as v78 from aggJoin5854046365650465683 group by v61,v74,v78)
select v61, v73 as v73, v77 as v77, v75 as v75, v74, v78 from aggJoin781083446743269670 join aggView4500775274086110488 using(v61));
create or replace view aggJoin525425074391644762 as (
with aggView8583051764822922980 as (select v61, MIN(v73) as v73, MIN(v77) as v77, MIN(v75) as v75, MIN(v74) as v74, MIN(v78) as v78 from aggJoin8230046932352495310 group by v61,v73,v75,v77,v78,v74)
select v43, v73, v77, v75, v74, v78 from aggView230944923672607698 join aggView8583051764822922980 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v43) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin525425074391644762;
