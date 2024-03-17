create or replace view aggView5921562599126215959 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin1148606439876793809 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView5921562599126215959 where mi_idx.movie_id=aggView5921562599126215959.v14 and info>'5.0';
create or replace view aggView3465220051167639116 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin4739518909603618619 as select v14, v9, v27 from aggJoin1148606439876793809 join aggView3465220051167639116 using(v1);
create or replace view aggView6719397454245575356 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin4739518909603618619 group by v14;
create or replace view aggJoin1498286522260559144 as select keyword_id as v3, v27, v26 from movie_keyword as mk, aggView6719397454245575356 where mk.movie_id=aggView6719397454245575356.v14;
create or replace view aggView4215037676226541116 as select v3, MIN(v27) as v27, MIN(v26) as v26 from aggJoin1498286522260559144 group by v3;
create or replace view aggJoin7202119403748576508 as select v27, v26 from keyword as k, aggView4215037676226541116 where k.id=aggView4215037676226541116.v3 and keyword LIKE '%sequel%';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin7202119403748576508;
