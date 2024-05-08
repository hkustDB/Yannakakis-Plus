create or replace view semiJoinView8685037222311808588 as select movie_id as v14, info_type_id as v1, info as v9 from movie_info_idx AS mi_idx where (info_type_id) in (select (id) from info_type AS it where info= 'rating');
create or replace view semiJoinView4212395977658746196 as select movie_id as v14, keyword_id as v3 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword LIKE '%sequel%');
create or replace view tAux49 as select id as v14, title as v15 from title where production_year>2005;
create or replace view semiJoinView1140337680226538173 as select v14, v1, v9 from semiJoinView8685037222311808588 where (v14) in (select (v14) from semiJoinView4212395977658746196);
create or replace view mi_idxAux76 as select v14, v9 from semiJoinView1140337680226538173;
create or replace view semiJoinView1666469385204373100 as select distinct v14, v15 from tAux49 where (v14) in (select (v14) from mi_idxAux76);
create or replace view semiEnum2119701396721013059 as select v9, v15 from semiJoinView1666469385204373100 join mi_idxAux76 using(v14);
select distinct v9, v15 from semiEnum2119701396721013059;
