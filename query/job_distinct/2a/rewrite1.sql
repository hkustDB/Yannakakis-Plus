create or replace view semiJoinView8904242034343814280 as select movie_id as v12, keyword_id as v18 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView1753038197327695502 as select movie_id as v12, company_id as v1 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[de]');
create or replace view semiJoinView3210417376677227355 as select id as v12, title as v20 from title AS t where (id) in (select (v12) from semiJoinView1753038197327695502);
create or replace view semiJoinView8410758975910307804 as select v12, v20 from semiJoinView3210417376677227355 where (v12) in (select (v12) from semiJoinView8904242034343814280);
create or replace view tAux79 as select v20 from semiJoinView8410758975910307804;
select distinct v20 from tAux79;
