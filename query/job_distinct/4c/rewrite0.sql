create or replace view semiJoinView1808854753387211911 as select movie_id as v14, keyword_id as v3 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiJoinView585929004317904287 as select movie_id as v14, info_type_id as v1, info as v9 from movie_info_idx AS mi_idx where (info_type_id) in (select (id) from info_type AS it where info= 'rating');
create or replace view tAux10 as select id as v14, title as v15 from title where production_year>1990;
create or replace view semiJoinView4389628301708588573 as select v14, v1, v9 from semiJoinView585929004317904287 where (v14) in (select (v14) from semiJoinView1808854753387211911);
create or replace view mi_idxAux80 as select v14, v9 from semiJoinView4389628301708588573;
create or replace view semiJoinView1323533165367644138 as select distinct v14, v15 from tAux10 where (v14) in (select (v14) from mi_idxAux80);
create or replace view semiEnum489372189650776875 as select v15, v9 from semiJoinView1323533165367644138 join mi_idxAux80 using(v14);
select distinct v9, v15 from semiEnum489372189650776875;
