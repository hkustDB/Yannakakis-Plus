create or replace view aggView835786001097028970 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5618474562897929350 as select movie_id as v14 from movie_keyword as mk, aggView835786001097028970 where mk.keyword_id=aggView835786001097028970.v3;
create or replace view aggView6182069523821464760 as select v14 from aggJoin5618474562897929350 group by v14;
create or replace view aggJoin4159679024762204743 as select id as v14, title as v15 from title as t, aggView6182069523821464760 where t.id=aggView6182069523821464760.v14 and production_year>2005;
create or replace view aggView5809035350787929524 as select v14, MIN(v15) as v27 from aggJoin4159679024762204743 group by v14;
create or replace view aggJoin1678884891324485168 as select info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView5809035350787929524 where mi_idx.movie_id=aggView5809035350787929524.v14 and info>'5.0';
create or replace view aggView6509515067423896786 as select v1, MIN(v27) as v27, MIN(v9) as v26 from aggJoin1678884891324485168 group by v1;
create or replace view aggJoin7871247003907447623 as select v27, v26 from info_type as it, aggView6509515067423896786 where it.id=aggView6509515067423896786.v1 and info= 'rating';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin7871247003907447623;
