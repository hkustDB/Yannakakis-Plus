create or replace view aggJoin8719275549600025731 as (
with aggView1565259176702886731 as (select id as v1, name as v73 from company_name as cn1 where country_code= '[nl]')
select movie_id as v49, v73 from movie_companies as mc1, aggView1565259176702886731 where mc1.company_id=aggView1565259176702886731.v1);
create or replace view aggJoin4178402367557888609 as (
with aggView5489019489468968222 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView5489019489468968222 where mc2.company_id=aggView5489019489468968222.v8);
create or replace view aggJoin7579993641205162210 as (
with aggView2999892213616781975 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView2999892213616781975 where mi_idx1.info_type_id=aggView2999892213616781975.v15);
create or replace view aggJoin3299380925501502547 as (
with aggView577752359427989738 as (select v49, MIN(v38) as v75 from aggJoin7579993641205162210 group by v49)
select id as v49, title as v50, kind_id as v19, v75 from title as t1, aggView577752359427989738 where t1.id=aggView577752359427989738.v49);
create or replace view aggJoin9183198566458625866 as (
with aggView5901519471546863637 as (select v49, MIN(v73) as v73 from aggJoin8719275549600025731 group by v49,v73)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v73 from movie_link as ml, aggView5901519471546863637 where ml.movie_id=aggView5901519471546863637.v49);
create or replace view aggJoin5799986224386593596 as (
with aggView888971670918236738 as (select id as v23 from link_type as lt where link LIKE '%follow%')
select v49, v61, v73 from aggJoin9183198566458625866 join aggView888971670918236738 using(v23));
create or replace view aggJoin4413162244176351212 as (
with aggView7206590875473026873 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView7206590875473026873 where mi_idx2.info_type_id=aggView7206590875473026873.v17 and info<'3.0');
create or replace view aggJoin4640168663839465888 as (
with aggView7715540895286514871 as (select v61, MIN(v43) as v76 from aggJoin4413162244176351212 group by v61)
select v61, v74 as v74, v76 from aggJoin4178402367557888609 join aggView7715540895286514871 using(v61));
create or replace view aggJoin7328425828352480287 as (
with aggView8269219929742706200 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select v49, v50, v75 from aggJoin3299380925501502547 join aggView8269219929742706200 using(v19));
create or replace view aggJoin2646287425796652983 as (
with aggView6449655342022658015 as (select v49, MIN(v75) as v75, MIN(v50) as v77 from aggJoin7328425828352480287 group by v49,v75)
select v61, v73 as v73, v75, v77 from aggJoin5799986224386593596 join aggView6449655342022658015 using(v49));
create or replace view aggJoin4248319026506267202 as (
with aggView4739499171188470948 as (select v61, MIN(v73) as v73, MIN(v75) as v75, MIN(v77) as v77 from aggJoin2646287425796652983 group by v61,v73,v75,v77)
select v61, v74 as v74, v76 as v76, v73, v75, v77 from aggJoin4640168663839465888 join aggView4739499171188470948 using(v61));
create or replace view aggJoin253304424440590247 as (
with aggView5330660738461490709 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView5330660738461490709 where t2.kind_id=aggView5330660738461490709.v21 and production_year= 2007);
create or replace view aggJoin5867895726981590815 as (
with aggView282478395294517868 as (select v61, MIN(v62) as v78 from aggJoin253304424440590247 group by v61)
select v74 as v74, v76 as v76, v73 as v73, v75 as v75, v77 as v77, v78 from aggJoin4248319026506267202 join aggView282478395294517868 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin5867895726981590815;
