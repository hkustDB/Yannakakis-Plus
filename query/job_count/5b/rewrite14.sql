create or replace view aggView8561199236583384487 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin479686831441332031 as select movie_id as v15, note as v9 from movie_companies as mc, aggView8561199236583384487 where mc.company_type_id=aggView8561199236583384487.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView2231550559289028361 as select v15, COUNT(*) as annot from aggJoin479686831441332031 group by v15;
create or replace view aggJoin6798658955360597914 as select id as v15, production_year as v19, annot from title as t, aggView2231550559289028361 where t.id=aggView2231550559289028361.v15 and production_year>2010;
create or replace view aggView3365494290089858031 as select v15, SUM(annot) as annot from aggJoin6798658955360597914 group by v15;
create or replace view aggJoin2302956743316534640 as select info_type_id as v3, info as v13, annot from movie_info as mi, aggView3365494290089858031 where mi.movie_id=aggView3365494290089858031.v15 and info IN ('USA','America');
create or replace view aggView4546266190107603403 as select id as v3 from info_type as it;
create or replace view aggJoin3227266417439231072 as select annot from aggJoin2302956743316534640 join aggView4546266190107603403 using(v3);
select SUM(annot) as v27 from aggJoin3227266417439231072;
