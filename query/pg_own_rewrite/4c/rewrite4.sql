create or replace view aggView544509623194433618 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin3353148382034652141 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView544509623194433618 where mi_idx.info_type_id=aggView544509623194433618.v1 and info>'2.0';
create or replace view aggView9076193872576858774 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin2722238579566451874 as select v14, v9, v27 from aggJoin3353148382034652141 join aggView9076193872576858774 using(v14);
create or replace view aggView3320514175086143493 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8516075185441940977 as select movie_id as v14 from movie_keyword as mk, aggView3320514175086143493 where mk.keyword_id=aggView3320514175086143493.v3;
create or replace view aggView8633382274344416869 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin2722238579566451874 group by v14,v27;
create or replace view aggJoin6849478762847788047 as select v27, v26 from aggJoin8516075185441940977 join aggView8633382274344416869 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin6849478762847788047;
