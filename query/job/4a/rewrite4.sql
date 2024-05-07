create or replace view aggView4204272888487713131 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin9093980339485026558 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView4204272888487713131 where mi_idx.movie_id=aggView4204272888487713131.v14 and info>'5.0';
create or replace view aggView1617528435834181255 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin610079395531383288 as select movie_id as v14 from movie_keyword as mk, aggView1617528435834181255 where mk.keyword_id=aggView1617528435834181255.v3;
create or replace view aggView4370301203812367674 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin5655493078060329555 as select v14, v9, v27 from aggJoin9093980339485026558 join aggView4370301203812367674 using(v1);
create or replace view aggView7303251054933064075 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin5655493078060329555 group by v14;
create or replace view aggJoin9153975720513772897 as select v27, v26 from aggJoin610079395531383288 join aggView7303251054933064075 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin9153975720513772897;
