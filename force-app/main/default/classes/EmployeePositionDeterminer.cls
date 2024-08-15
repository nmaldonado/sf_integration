public class EmployeePositionDeterminer {

    public static String determineEmployeePosition(String name, String salary) {
        String text, position;
        //[name] is assigned to the position of [position] with a salary of $[salary].
        position = salary == '5000' ? 'Manager' : 'Associate';

        text =  name + ' is assigned to the position of ' + position +  ' with a salary of $'+ salary+'.';
        return text;
    }

}