create or replace view aggView5794238710839455522 as select name as v9, id as v8 from company_name as cn2;
create or replace view aggView7972370814855866425 as select id as v1, name as v2 from company_name as cn1 where country_code= '[nl]';
create or replace view aggJoin105851701361657244 as (
with aggView2516942448132652621 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView2516942448132652621 where mi_idx1.info_type_id=aggView2516942448132652621.v15);
create or replace view aggView4186054584864642070 as select v49, v38 from aggJoin105851701361657244 group by v49,v38;
create or replace view aggJoin7296841842026659890 as (
with aggView8074922341951419979 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView8074922341951419979 where mi_idx2.info_type_id=aggView8074922341951419979.v17 and info<'3.0');
create or replace view aggView5277312168976947842 as select v61, v43 from aggJoin7296841842026659890 group by v61,v43;
create or replace view aggJoin4656367754627226635 as (
with aggView3480500331013910294 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView3480500331013910294 where t2.kind_id=aggView3480500331013910294.v21 and production_year= 2007);
create or replace view aggView6886915029723323319 as select v62, v61 from aggJoin4656367754627226635 group by v62,v61;
create or replace view aggJoin2246577169668772080 as (
with aggView8008926426821776985 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView8008926426821776985 where t1.kind_id=aggView8008926426821776985.v19);
create or replace view aggView2099470646469685450 as select v50, v49 from aggJoin2246577169668772080 group by v50,v49;
create or replace view aggJoin1780818432455877286 as (
with aggView5798014068663306175 as (select v8, MIN(v9) as v74 from aggView5794238710839455522 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView5798014068663306175 where mc2.company_id=aggView5798014068663306175.v8);
create or replace view aggJoin6346122112812327705 as (
with aggView8990362242606635946 as (select v1, MIN(v2) as v73 from aggView7972370814855866425 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView8990362242606635946 where mc1.company_id=aggView8990362242606635946.v1);
create or replace view aggJoin4036011366083400787 as (
with aggView2933448705129047014 as (select v61, MIN(v43) as v76 from aggView5277312168976947842 group by v61)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v76 from movie_link as ml, aggView2933448705129047014 where ml.linked_movie_id=aggView2933448705129047014.v61);
create or replace view aggJoin4871083895951248863 as (
with aggView3697615860276292732 as (select v61, MIN(v62) as v78 from aggView6886915029723323319 group by v61)
select v49, v61, v23, v76 as v76, v78 from aggJoin4036011366083400787 join aggView3697615860276292732 using(v61));
create or replace view aggJoin8780358557040510188 as (
with aggView3366142264488671720 as (select v61, MIN(v74) as v74 from aggJoin1780818432455877286 group by v61,v74)
select v49, v23, v76 as v76, v78 as v78, v74 from aggJoin4871083895951248863 join aggView3366142264488671720 using(v61));
create or replace view aggJoin5242463027907167822 as (
with aggView7672351263072667244 as (select v49, MIN(v73) as v73 from aggJoin6346122112812327705 group by v49,v73)
select v49, v38, v73 from aggView4186054584864642070 join aggView7672351263072667244 using(v49));
create or replace view aggJoin3647801496617174212 as (
with aggView2359142341953067315 as (select id as v23 from link_type as lt where link LIKE '%follow%')
select v49, v76, v78, v74 from aggJoin8780358557040510188 join aggView2359142341953067315 using(v23));
create or replace view aggJoin8773306755862296617 as (
with aggView3689106686829913793 as (select v49, MIN(v76) as v76, MIN(v78) as v78, MIN(v74) as v74 from aggJoin3647801496617174212 group by v49,v74,v78,v76)
select v49, v38, v73 as v73, v76, v78, v74 from aggJoin5242463027907167822 join aggView3689106686829913793 using(v49));
create or replace view aggJoin625987803488922228 as (
with aggView1994019466190757169 as (select v49, MIN(v73) as v73, MIN(v76) as v76, MIN(v78) as v78, MIN(v74) as v74, MIN(v38) as v75 from aggJoin8773306755862296617 group by v49,v74,v78,v76,v73)
select v50, v73, v76, v78, v74, v75 from aggView2099470646469685450 join aggView1994019466190757169 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v50) as v77,MIN(v78) as v78 from aggJoin625987803488922228;
