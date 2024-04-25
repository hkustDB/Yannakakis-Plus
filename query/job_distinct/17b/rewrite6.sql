create or replace view semiJoinView6781742954717040387 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView6663741533867562155 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView2097223716422317929 as select v3, v20 from semiJoinView6781742954717040387 where (v3) in (select (v3) from semiJoinView6663741533867562155);
create or replace view semiJoinView6301271909948275681 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView2097223716422317929);
create or replace view semiJoinView3464257312671523463 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView6301271909948275681);
create or replace view semiJoinView1099800133593916978 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView3464257312671523463) and name LIKE 'Z%';
create or replace view nAux13 as select v27 from semiJoinView1099800133593916978;
select distinct v27 from nAux13;
