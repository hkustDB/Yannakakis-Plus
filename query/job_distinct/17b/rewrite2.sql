create or replace view semiJoinView1438235062190360556 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView1095544458377661758 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView6848215804317222871 as select v3, v25 from semiJoinView1095544458377661758 where (v3) in (select (v3) from semiJoinView1438235062190360556);
create or replace view semiJoinView4642655704197536893 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView6848215804317222871);
create or replace view semiJoinView8510524745667702163 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView4642655704197536893);
create or replace view semiJoinView5112359458699738583 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView8510524745667702163);
create or replace view nAux19 as select v27 from semiJoinView5112359458699738583;
select distinct v27 from nAux19;
