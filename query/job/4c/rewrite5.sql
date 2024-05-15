create or replace view aggView428925952888533706 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin2100418337592208370 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView428925952888533706 where mi_idx.info_type_id=aggView428925952888533706.v1 and info>'2.0';
create or replace view aggView3906344814148012929 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin4470100165218782732 as select v14, v9, v27 from aggJoin2100418337592208370 join aggView3906344814148012929 using(v14);
create or replace view aggView2582591019042440675 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2757822110480441730 as select movie_id as v14 from movie_keyword as mk, aggView2582591019042440675 where mk.keyword_id=aggView2582591019042440675.v3;
create or replace view aggView6989864445540766803 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin4470100165218782732 group by v14;
create or replace view aggJoin8525370544553541353 as select v27, v26 from aggJoin2757822110480441730 join aggView6989864445540766803 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin8525370544553541353;
