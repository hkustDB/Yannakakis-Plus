create or replace view aggView6569168937410526266 as select name as v2, id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin6744498103942971139 as (
with aggView552631096768010531 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView552631096768010531 where mi.info_type_id=aggView552631096768010531.v21 and info IN ('Drama','Horror'));
create or replace view aggJoin3981827621052437739 as (
with aggView5044398706258736354 as (select v29 from aggJoin6744498103942971139 group by v29)
select id as v29, title as v30, production_year as v33 from title as t, aggView5044398706258736354 where t.id=aggView5044398706258736354.v29 and production_year<=2008 and production_year>=2005);
create or replace view aggView1692528205406702803 as select v30, v29 from aggJoin3981827621052437739 group by v30,v29;
create or replace view aggJoin2303504657962040862 as (
with aggView3169581435373419833 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView3169581435373419833 where mi_idx.info_type_id=aggView3169581435373419833.v26);
create or replace view aggJoin7684110000760404408 as (
with aggView2032687664656038417 as (select v27, v29 from aggJoin2303504657962040862 group by v27,v29)
select v29, v27 from aggView2032687664656038417 where v27>'8.0');
create or replace view aggJoin8239161110797107127 as (
with aggView3630249655447541739 as (select v29, MIN(v30) as v43 from aggView1692528205406702803 group by v29)
select v29, v27, v43 from aggJoin7684110000760404408 join aggView3630249655447541739 using(v29));
create or replace view aggJoin4990848736566322730 as (
with aggView288653214985181170 as (select v29, MIN(v43) as v43, MIN(v27) as v42 from aggJoin8239161110797107127 group by v29,v43)
select company_id as v1, company_type_id as v8, v43, v42 from movie_companies as mc, aggView288653214985181170 where mc.movie_id=aggView288653214985181170.v29);
create or replace view aggJoin2503569390280578846 as (
with aggView8841900250162399073 as (select id as v8 from company_type as ct where kind= 'production companies')
select v1, v43, v42 from aggJoin4990848736566322730 join aggView8841900250162399073 using(v8));
create or replace view aggJoin6481675684904217779 as (
with aggView7659134872683771930 as (select v1, MIN(v43) as v43, MIN(v42) as v42 from aggJoin2503569390280578846 group by v1,v43,v42)
select v2, v43, v42 from aggView6569168937410526266 join aggView7659134872683771930 using(v1));
select MIN(v2) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin6481675684904217779;
