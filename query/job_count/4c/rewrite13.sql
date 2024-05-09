create or replace view aggView8537344464137389012 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5648599391264636609 as select movie_id as v14 from movie_keyword as mk, aggView8537344464137389012 where mk.keyword_id=aggView8537344464137389012.v3;
create or replace view aggView23302423099007312 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin3046135506353387849 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView23302423099007312 where mi_idx.info_type_id=aggView23302423099007312.v1 and info>'2.0';
create or replace view aggView8346545835393399478 as select v14, COUNT(*) as annot from aggJoin3046135506353387849 group by v14;
create or replace view aggJoin3310951434711261845 as select id as v14, production_year as v18, annot from title as t, aggView8346545835393399478 where t.id=aggView8346545835393399478.v14 and production_year>1990;
create or replace view aggView1708124447886300855 as select v14, SUM(annot) as annot from aggJoin3310951434711261845 group by v14;
create or replace view aggJoin2503643653140255167 as select annot from aggJoin5648599391264636609 join aggView1708124447886300855 using(v14);
select SUM(annot) as v26 from aggJoin2503643653140255167;
