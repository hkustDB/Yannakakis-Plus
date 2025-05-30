create or replace view semiUp820867913210520249 as select movie_id as v29, keyword_id as v27 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k where keyword= 'sequel');
create or replace view semiUp2454678426240053395 as select movie_id as v29, link_type_id as v13 from movie_link AS ml where (link_type_id) in (select id from link_type AS lt where link LIKE '%follow%');
create or replace view semiUp7001034291149718884 as select v29, v13 from semiUp2454678426240053395 where (v29) in (select v29 from semiUp820867913210520249);
create or replace view semiUp5113104212661582052 as select id as v29, title as v33 from title AS t where (id) in (select v29 from semiUp7001034291149718884) and production_year<=2010 and production_year>=1950;
create or replace view semiUp8853116937128020899 as select movie_id as v29, company_id as v17, company_type_id as v18 from movie_companies AS mc where (movie_id) in (select v29 from semiUp5113104212661582052);
create or replace view semiUp3218964594638649853 as select id as v17, name as v2 from company_name AS cn where (id) in (select v17 from semiUp8853116937128020899) and country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view semiUp4093420680021599326 as select id as v18 from company_type AS ct where kind= 'production companies';
create or replace view semiUp3868763849310479438 as select movie_id as v29 from movie_info AS mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English');
create or replace view semiDown4859792422789016357 as select v18 from semiUp4093420680021599326;
create or replace view semiDown3176230347630663689 as select v17, v2 from semiUp3218964594638649853;
create or replace view semiDown3987874010317616038 as select v29, v17, v18 from semiUp8853116937128020899 where (v17) in (select v17 from semiDown3176230347630663689);
create or replace view semiDown2123750019749859846 as select v29, v33 from semiUp5113104212661582052 where (v29) in (select v29 from semiDown3987874010317616038);
create or replace view semiDown2639229692944536367 as select v29, v13 from semiUp7001034291149718884 where (v29) in (select v29 from semiDown2123750019749859846);
create or replace view semiDown4892858326537458554 as select id as v13, link as v14 from link_type AS lt where (id) in (select v13 from semiDown2639229692944536367) and link LIKE '%follow%';
create or replace view semiDown5148617771501984186 as select v29, v27 from semiUp820867913210520249 where (v29) in (select v29 from semiDown2639229692944536367);
create or replace view semiDown4888384993137102333 as select id as v27 from keyword AS k where (id) in (select v27 from semiDown5148617771501984186) and keyword= 'sequel';
create or replace view aggView6329594874321052088 as select v27 from semiDown4888384993137102333;
create or replace view aggJoin564496936836855519 as select v29 from semiDown5148617771501984186 join aggView6329594874321052088 using(v27);
create or replace view aggView5101131509181021749 as select v29 from aggJoin564496936836855519 group by v29;
create or replace view aggJoin685701051380893204 as select v29, v13 from semiDown2639229692944536367 join aggView5101131509181021749 using(v29);
create or replace view aggView8320560981664134948 as select v13, v14 as v45 from semiDown4892858326537458554;
create or replace view aggJoin7556279331821289926 as select v29, v45 from aggJoin685701051380893204 join aggView8320560981664134948 using(v13);
create or replace view aggView155478617230890497 as select v29, MIN(v45) as v45 from aggJoin7556279331821289926 group by v29,v45;
create or replace view aggJoin8125596426166444541 as select v29, v33, v45 from semiDown2123750019749859846 join aggView155478617230890497 using(v29);
create or replace view aggView1571717135476491945 as select v29, MIN(v45) as v45, MIN(v33) as v46 from aggJoin8125596426166444541 group by v29,v45;
create or replace view aggJoin1911270974300394104 as select v29, v17, v18, v45, v46 from semiDown3987874010317616038 join aggView1571717135476491945 using(v29);
create or replace view aggView2505146553501982232 as select v17, v18, v29, MIN(v45) as v45, MIN(v46) as v46 from aggJoin1911270974300394104 group by v17,v18,v29,v45,v46;
create or replace view aggJoin1514003888647402388 as select v2, v18, v29, v45, v46 from semiDown3176230347630663689 join aggView2505146553501982232 using(v17);
create or replace view aggView2715682399746559099 as select v18, v29, MIN(v45) as v45, MIN(v46) as v46, MIN(v2) as v44 from aggJoin1514003888647402388 group by v18,v29,v45,v46;
create or replace view aggJoin7157183234146083644 as select v18, v29, v45, v46, v44 from semiDown4859792422789016357 join aggView2715682399746559099 using(v18);
create or replace view aggView5697603974094189674 as select v29, MIN(v45) as v45, MIN(v46) as v46, MIN(v44) as v44 from aggJoin7157183234146083644 group by v29,v45,v46,v44;
create or replace view aggJoin874618226356160330 as select v29, v45, v46, v44 from semiUp3868763849310479438 join aggView5697603974094189674 using(v29);
select MIN(v44) as v44, MIN(v45) as v45, MIN(v46) as v46 from aggJoin874618226356160330;

