create or replace view aggView5774337572855819755 as select id as v14 from title as t where production_year>2010;
create or replace view aggJoin4090569469947772347 as select movie_id as v14, info_type_id as v1, info as v9 from movie_info_idx as mi_idx, aggView5774337572855819755 where mi_idx.movie_id=aggView5774337572855819755.v14 and info>'9.0';
create or replace view aggView330974715932421617 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin1111105557603932635 as select v14, v9 from aggJoin4090569469947772347 join aggView330974715932421617 using(v1);
create or replace view aggView6901889150012597197 as select v14, COUNT(*) as annot from aggJoin1111105557603932635 group by v14;
create or replace view aggJoin8554714626556075620 as select keyword_id as v3, annot from movie_keyword as mk, aggView6901889150012597197 where mk.movie_id=aggView6901889150012597197.v14;
create or replace view aggView4543265009063785658 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5048444585045943114 as select annot from aggJoin8554714626556075620 join aggView4543265009063785658 using(v3);
select SUM(annot) as v26 from aggJoin5048444585045943114;
