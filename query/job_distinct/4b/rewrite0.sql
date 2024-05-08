create or replace view semiJoinView5255854793169673863 as select movie_id as v14, keyword_id as v3 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword LIKE '%sequel%');
create or replace view tAux98 as select id as v14, title as v15 from title where production_year>2010;
create or replace view semiJoinView3712476565770606746 as select movie_id as v14, info_type_id as v1, info as v9 from movie_info_idx AS mi_idx where (movie_id) in (select (v14) from semiJoinView5255854793169673863);
create or replace view semiJoinView3685461610446091837 as select v14, v1, v9 from semiJoinView3712476565770606746 where (v1) in (select (id) from info_type AS it where info= 'rating');
create or replace view mi_idxAux54 as select v14, v9 from semiJoinView3685461610446091837;
create or replace view semiJoinView675559720593507459 as select distinct v14, v15 from tAux98 where (v14) in (select (v14) from mi_idxAux54);
create or replace view semiEnum6859721482893479107 as select v9, v15 from semiJoinView675559720593507459 join mi_idxAux54 using(v14);
select distinct v9, v15 from semiEnum6859721482893479107;
