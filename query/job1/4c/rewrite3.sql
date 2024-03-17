create or replace view aggView2678765441343676693 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4862154285118259981 as select movie_id as v14 from movie_keyword as mk, aggView2678765441343676693 where mk.keyword_id=aggView2678765441343676693.v3;
create or replace view aggView6841842275881989858 as select v14 from aggJoin4862154285118259981 group by v14;
create or replace view aggJoin1365882215539314518 as select id as v14, title as v15 from title as t, aggView6841842275881989858 where t.id=aggView6841842275881989858.v14 and production_year>1990;
create or replace view aggView5600650390900683636 as select v14, MIN(v15) as v27 from aggJoin1365882215539314518 group by v14;
create or replace view aggJoin3444195475650053945 as select info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView5600650390900683636 where mi_idx.movie_id=aggView5600650390900683636.v14 and info>'2.0';
create or replace view aggView4290959757228812720 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin8699033188434353300 as select v9, v27 from aggJoin3444195475650053945 join aggView4290959757228812720 using(v1);
select MIN(v9) as v26,MIN(v27) as v27 from aggJoin8699033188434353300;
