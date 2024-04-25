create or replace view semiJoinView5250910892924417763 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView6910264248053213190 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView8604940572990229503 as select v3, v20 from semiJoinView6910264248053213190 where (v3) in (select (id) from title AS t);
create or replace view semiJoinView2875694235401592766 as select v3, v25 from semiJoinView5250910892924417763 where (v3) in (select (v3) from semiJoinView8604940572990229503);
create or replace view semiJoinView6732314513131799383 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView2875694235401592766);
create or replace view semiJoinView1871151477993316002 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView6732314513131799383);
create or replace view nAux69 as select v27 from semiJoinView1871151477993316002;
select distinct v27 from nAux69;
