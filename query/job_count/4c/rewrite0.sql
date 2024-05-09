create or replace view aggView4260281392849485351 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin5091311637555988365 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView4260281392849485351 where mi_idx.info_type_id=aggView4260281392849485351.v1 and info>'2.0';
create or replace view aggView339082216580140402 as select v14, COUNT(*) as annot from aggJoin5091311637555988365 group by v14;
create or replace view aggJoin8145124808889393507 as select id as v14, production_year as v18, annot from title as t, aggView339082216580140402 where t.id=aggView339082216580140402.v14 and production_year>1990;
create or replace view aggView8225966099395703544 as select v14, SUM(annot) as annot from aggJoin8145124808889393507 group by v14;
create or replace view aggJoin8311034137505127129 as select keyword_id as v3, annot from movie_keyword as mk, aggView8225966099395703544 where mk.movie_id=aggView8225966099395703544.v14;
create or replace view aggView1891684432275971642 as select v3, SUM(annot) as annot from aggJoin8311034137505127129 group by v3;
create or replace view aggJoin4813412324754643802 as select keyword as v4, annot from keyword as k, aggView1891684432275971642 where k.id=aggView1891684432275971642.v3 and keyword LIKE '%sequel%';
select SUM(annot) as v26 from aggJoin4813412324754643802;
